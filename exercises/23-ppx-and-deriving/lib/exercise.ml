type color = Red | Green | Blue
[@@deriving show, eq, ord]

type point = { x : float; y : float }
[@@deriving show, eq]

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree
[@@deriving show, eq]

(** [color_to_hex c] returns the hex string for color [c].
    Red -> "#FF0000", Green -> "#00FF00", Blue -> "#0000FF" *)
let color_to_hex (c : color) : string =
  ignore c; failwith "not implemented"

(** [distance p1 p2] returns the Euclidean distance between [p1] and [p2]. *)
let distance (p1 : point) (p2 : point) : float =
  ignore (p1, p2); failwith "not implemented"

(** [tree_depth t] returns the maximum depth of tree [t] (Leaf has depth 0). *)
let rec tree_depth (t : 'a tree) : int =
  ignore t; failwith "not implemented"

(** [tree_insert x t] inserts [x] into BST [t] using the derived compare. *)
let rec tree_insert (x : 'a) (t : 'a tree) : 'a tree =
  ignore (x, t); failwith "not implemented"
