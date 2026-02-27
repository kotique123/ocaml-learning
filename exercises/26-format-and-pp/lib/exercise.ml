(** [pp_list pp_elem ppf lst] pretty-prints a list using [pp_elem] for each element.
    Format: "[elem1; elem2; elem3]" *)
let pp_list (_pp_elem : Format.formatter -> 'a -> unit) (_ppf : Format.formatter) (_lst : 'a list) : unit =
  failwith "not implemented"

(** [pp_tree pp_val ppf t] pretty-prints a binary tree.
    type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree
    Format: "." for Leaf, "(left val right)" for Node *)
type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

let pp_tree (_pp_val : Format.formatter -> 'a -> unit) (_ppf : Format.formatter) (_t : 'a tree) : unit =
  failwith "not implemented"

(** [pp_record ppf fields] pretty-prints a list of (key, value) string pairs as a record.
    Format: "{ key1 = val1; key2 = val2 }" *)
let pp_record (_ppf : Format.formatter) (_fields : (string * string) list) : unit =
  failwith "not implemented"

(** [format_table headers rows] formats a list of string rows as an aligned ASCII table.
    Returns the table as a string. Each row is a string list. *)
let format_table (_headers : string list) (_rows : string list list) : string =
  failwith "not implemented"
