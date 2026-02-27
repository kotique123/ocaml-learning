open Angstrom

(** [parse_int] parses an optionally-signed integer. *)
let parse_int : int t = failwith "not implemented"

(** [parse_csv_line] parses a single CSV line into a string list.
    Fields are separated by commas. Quoted fields may contain commas.
    E.g. [parse "a,b,\"c,d\",e"] = Ok ["a";"b";"c,d";"e"] *)
let parse_csv_line : string list t = failwith "not implemented"

(** [parse_json_bool] parses "true" or "false" into a bool. *)
let parse_json_bool : bool t = failwith "not implemented"

(** [parse_list_of_ints] parses "[1, 2, 3]" into [1;2;3]. *)
let parse_list_of_ints : int list t = failwith "not implemented"

(** Helper: run a parser on a string, return Ok/Error. *)
let run (p : 'a t) (s : string) : ('a, string) result =
  Angstrom.parse_string ~consume:All p s
