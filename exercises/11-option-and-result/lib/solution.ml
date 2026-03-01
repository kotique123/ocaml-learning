let safe_div (a : int) (b : int) : int option =
  if b = 0 then None else Some (a / b)

let safe_sqrt (x : float) : float option =
  if x < 0.0 then None else Some (Float.sqrt x)

let option_map (f : 'a -> 'b) (opt : 'a option) : 'b option =
  match opt with None -> None | Some x -> Some (f x)

let option_bind (opt : 'a option) (f : 'a -> 'b option) : 'b option =
  match opt with None -> None | Some x -> f x

let parse_int (s : string) : (int, string) result =
  match int_of_string_opt s with
  | Some n -> Ok n
  | None -> Error ("not an integer: " ^ s)

let result_map (f : 'a -> 'b) (r : ('a, 'e) result) : ('b, 'e) result =
  match r with Error e -> Error e | Ok x -> Ok (f x)

let chain_divs (a : int) (b : int) (c : int) : int option =
  option_bind (safe_div a b) (fun r -> safe_div r c)
