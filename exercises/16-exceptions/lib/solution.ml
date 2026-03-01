exception Division_by_zero_custom of string
exception Out_of_range of { index : int; length : int }

let safe_div (a : int) (b : int) : int =
  if b = 0 then raise (Division_by_zero_custom "division by zero") else a / b

let safe_nth (lst : 'a list) (i : int) : 'a =
  let n = List.length lst in
  if i < 0 || i >= n then raise (Out_of_range { index = i; length = n })
  else List.nth lst i

let try_div (a : int) (b : int) : (int, string) result =
  try Ok (safe_div a b)
  with Division_by_zero_custom msg -> Error msg

let with_default (default : 'a) (f : unit -> 'a) : 'a =
  try f () with _ -> default

let validate_age (n : int) : int =
  if n < 0 || n > 150 then invalid_arg "age must be 0..150" else n
