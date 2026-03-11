(** [int_to_string n] converts integer [n] to its string representation. *)
let int_to_string (n : int) : string = string_of_int(n)

(** [float_to_int f] truncates float [f] to an integer. *)
let float_to_int (f : float) : int = int_of_float(f)

(** [char_to_code c] returns the ASCII code of character [c]. *)
let char_to_code (c : char) : int = int_of_char(c)

(** [code_to_char n] returns the character with ASCII code [n]. *)
let code_to_char (n : int) : char = char_of_int(n)

(** [is_digit c] returns true if [c] is a digit character '0'..'9'. *)
let is_digit (c : char) : bool =
  

(** [celsius_to_fahrenheit c] converts Celsius to Fahrenheit: f = c *. 9.0 /. 5.0 +. 32.0 *)
let celsius_to_fahrenheit (c : float) : float = failwith "not implemented"
