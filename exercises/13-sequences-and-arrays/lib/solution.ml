let array_sum (arr : int array) : int =
  Array.fold_left ( + ) 0 arr

let array_rotate (arr : 'a array) (n : int) : 'a array =
  let len = Array.length arr in
  if len = 0 then arr
  else
    let n = ((n mod len) + len) mod len in
    Array.init len (fun i -> arr.((i + n) mod len))

let running_total (arr : int array) : int array =
  let result = Array.copy arr in
  for i = 1 to Array.length arr - 1 do
    result.(i) <- result.(i) + result.(i - 1)
  done;
  result

let naturals () : int Seq.t =
  let rec go n () = Seq.Cons (n, go (n + 1)) in
  go 0

let seq_take (n : int) (seq : 'a Seq.t) : 'a list =
  let rec aux n seq acc =
    if n = 0 then List.rev acc
    else
      match seq () with
      | Seq.Nil -> List.rev acc
      | Seq.Cons (x, rest) -> aux (n - 1) rest (x :: acc)
  in
  aux n seq []

let seq_squares (n : int) : int list =
  seq_take n (Seq.map (fun x -> x * x) (Seq.map (fun x -> x + 1) (naturals ())))
