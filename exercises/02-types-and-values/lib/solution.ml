let int_to_string (n : int) : string = string_of_int n
let float_to_int (f : float) : int = int_of_float f
let char_to_code (c : char) : int = Char.code c
let code_to_char (n : int) : char = Char.chr n
let is_digit (c : char) : bool = c >= '0' && c <= '9'
let celsius_to_fahrenheit (c : float) : float = c *. 9.0 /. 5.0 +. 32.0
