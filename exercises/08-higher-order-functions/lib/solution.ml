let rec my_fold_left (f : 'acc -> 'a -> 'acc) (acc : 'acc) (lst : 'a list) : 'acc =
  match lst with
  | [] -> acc
  | h :: t -> my_fold_left f (f acc h) t

let compose (f : 'b -> 'c) (g : 'a -> 'b) (x : 'a) : 'c = f (g x)
let apply_twice (f : 'a -> 'a) (x : 'a) : 'a = f (f x)

let count_if (pred : 'a -> bool) (lst : 'a list) : int =
  List.fold_left (fun acc x -> if pred x then acc + 1 else acc) 0 lst

let flat_map (f : 'a -> 'b list) (lst : 'a list) : 'b list =
  List.fold_left (fun acc x -> acc @ f x) [] lst

let partition_by (pred : 'a -> bool) (lst : 'a list) : 'a list * 'a list =
  List.fold_right
    (fun x (yes, no) -> if pred x then (x :: yes, no) else (yes, x :: no))
    lst ([], [])

let group_by (n : int) (lst : 'a list) : 'a list list =
  let rec aux acc current count = function
    | [] ->
      if current = [] then List.rev acc
      else List.rev (List.rev current :: acc)
    | x :: rest ->
      if count = n then aux (List.rev current :: acc) [ x ] 1 rest
      else aux acc (x :: current) (count + 1) rest
  in
  aux [] [] 0 lst
