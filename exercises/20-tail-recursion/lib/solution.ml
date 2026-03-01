let rec sum_naive (lst : int list) : int =
  match lst with [] -> 0 | h :: t -> h + sum_naive t

let sum_tr (lst : int list) : int =
  let rec aux acc = function [] -> acc | h :: t -> aux (acc + h) t in
  aux 0 lst

let reverse_tr (lst : 'a list) : 'a list =
  let rec aux acc = function [] -> acc | h :: t -> aux (h :: acc) t in
  aux [] lst

let flatten_tr (lst : 'a list list) : 'a list =
  let rec aux acc = function
    | [] -> List.rev acc
    | h :: t -> aux (List.rev_append h acc) t
  in
  aux [] lst

let map_tr (f : 'a -> 'b) (lst : 'a list) : 'b list =
  let rec aux acc = function
    | [] -> List.rev acc
    | h :: t -> aux (f h :: acc) t
  in
  aux [] lst

let fibonacci_tr (n : int) : int =
  let rec aux a b = function 0 -> a | n -> aux b (a + b) (n - 1) in
  aux 0 1 n

let range (lo : int) (hi : int) : int list =
  let rec aux acc i = if i < lo then acc else aux (i :: acc) (i - 1) in
  aux [] (hi - 1)
