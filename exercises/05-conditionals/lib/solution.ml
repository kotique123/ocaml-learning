let abs_val (n : int) : int = if n >= 0 then n else -n

let clamp (lo : int) (hi : int) (x : int) : int =
  if x < lo then lo else if x > hi then hi else x

let fizzbuzz (n : int) : string =
  match (n mod 3 = 0, n mod 5 = 0) with
  | (true, true) -> "FizzBuzz"
  | (true, false) -> "Fizz"
  | (false, true) -> "Buzz"
  | (false, false) -> string_of_int n

let grade (score : int) : string =
  if score >= 90 then "A"
  else if score >= 80 then "B"
  else if score >= 70 then "C"
  else if score >= 60 then "D"
  else "F"

let leap_year (y : int) : bool =
  (y mod 4 = 0 && y mod 100 <> 0) || (y mod 400 = 0)
