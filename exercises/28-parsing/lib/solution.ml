open Angstrom

let parse_int : int t =
  take_while1 (fun c -> (c >= '0' && c <= '9') || c = '-') >>| int_of_string

let quoted_field : string t =
  char '"' *> take_while (fun c -> c <> '"') <* char '"'

let unquoted_field : string t =
  take_while (fun c -> c <> ',' )

let csv_field : string t = quoted_field <|> unquoted_field

let parse_csv_line : string list t =
  sep_by (char ',') csv_field

let parse_json_bool : bool t =
  (string "true" >>| fun _ -> true) <|> (string "false" >>| fun _ -> false)

let ws : unit t = skip_while (fun c -> c = ' ' || c = '\t')

let parse_list_of_ints : int list t =
  char '[' *> ws *> sep_by (ws *> char ',' *> ws) parse_int <* ws <* char ']'

let run (p : 'a t) (s : string) : ('a, string) result =
  Angstrom.parse_string ~consume:All p s
