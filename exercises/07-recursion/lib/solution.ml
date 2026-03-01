let rec factorial (n : int) : int =
  if n <= 0 then 1 else n * factorial (n - 1)

let rec fibonacci (n : int) : int =
  if n <= 1 then n else fibonacci (n - 1) + fibonacci (n - 2)

let rec my_length (lst : 'a list) : int =
  match lst with
  | [] -> 0
  | _ :: t -> 1 + my_length t

let rec my_reverse (lst : 'a list) : 'a list =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (h :: acc) t
  in
  aux [] lst

let rec my_map (f : 'a -> 'b) (lst : 'a list) : 'b list =
  match lst with
  | [] -> []
  | h :: t -> f h :: my_map f t

let rec count_down (n : int) : int list =
  if n < 0 then [] else n :: count_down (n - 1)

let rec power (base : int) (exp : int) : int =
  if exp = 0 then 1 else base * power base (exp - 1)
