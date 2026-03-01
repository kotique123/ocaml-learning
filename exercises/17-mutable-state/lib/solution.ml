let swap (r1 : 'a ref) (r2 : 'a ref) : unit =
  let tmp = !r1 in
  r1 := !r2;
  r2 := tmp

let array_fill_range (arr : 'a array) (lo : int) (hi : int) (v : 'a) : unit =
  for i = lo to hi do
    arr.(i) <- v
  done

let histogram (lst : 'a list) : ('a, int) Hashtbl.t =
  let tbl = Hashtbl.create 16 in
  List.iter
    (fun x ->
      let n = try Hashtbl.find tbl x with Not_found -> 0 in
      Hashtbl.replace tbl x (n + 1))
    lst;
  tbl

let dedup_array (arr : 'a array) : 'a array =
  let n = Array.length arr in
  if n = 0 then [||]
  else
    let result = ref [ arr.(0) ] in
    for i = 1 to n - 1 do
      if arr.(i) <> arr.(i - 1) then result := arr.(i) :: !result
    done;
    Array.of_list (List.rev !result)

let queue_rotate (q : 'a Queue.t) (n : int) : unit =
  for _ = 1 to n do
    if not (Queue.is_empty q) then Queue.add (Queue.pop q) q
  done
