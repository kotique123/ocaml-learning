let force_once (v : 'a lazy_t) : 'a = Lazy.force v

let memoize (f : 'a -> 'b) : 'a -> 'b =
  let tbl = Hashtbl.create 16 in
  fun x ->
    match Hashtbl.find_opt tbl x with
    | Some v -> v
    | None ->
      let v = f x in
      Hashtbl.add tbl x v;
      v

let fib_memo : int -> int =
  let memo = Hashtbl.create 128 in
  let rec fib n =
    match Hashtbl.find_opt memo n with
    | Some v -> v
    | None ->
      let v = if n <= 1 then n else fib (n - 1) + fib (n - 2) in
      Hashtbl.add memo n v;
      v
  in
  fib

let lazy_range (lo : int) (hi : int) : int Seq.t =
  let rec go i () = if i >= hi then Seq.Nil else Seq.Cons (i, go (i + 1)) in
  go lo

let lazy_filter (pred : 'a -> bool) (seq : 'a Seq.t) : 'a Seq.t =
  Seq.filter pred seq

let lazy_fibs : unit -> int Seq.t =
  fun () ->
    let rec go a b () = Seq.Cons (a, go b (a + b)) in
    go 0 1
