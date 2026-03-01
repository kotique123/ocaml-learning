let sum (lst : int list) : int = List.fold_left ( + ) 0 lst
let product (lst : int list) : int = List.fold_left ( * ) 1 lst
let evens (lst : int list) : int list = List.filter (fun x -> x mod 2 = 0) lst
let double_all (lst : int list) : int list = List.map (fun x -> x * 2) lst

let my_last (lst : 'a list) : 'a option =
  let rec aux = function
    | [] -> None
    | [ x ] -> Some x
    | _ :: t -> aux t
  in
  aux lst

let rec zip (lst1 : 'a list) (lst2 : 'b list) : ('a * 'b) list =
  match (lst1, lst2) with
  | ([], _) | (_, []) -> []
  | (h1 :: t1, h2 :: t2) -> (h1, h2) :: zip t1 t2

let flatten (lst : 'a list list) : 'a list =
  List.fold_left (fun acc x -> acc @ x) [] lst
