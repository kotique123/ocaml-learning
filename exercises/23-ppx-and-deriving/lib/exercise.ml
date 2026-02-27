type color = Red | Green | Blue
[@@deriving show, eq, ord]

type point = { x : float; y : float }
[@@deriving show, eq]

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree
[@@deriving show, eq]

(** [color_to_hex c] returns the hex string for color [c].
    Red -> "#FF0000", Green -> "#00FF00", Blue -> "#0000FF" *)
let color_to_hex = function
  | Red   -> "#FF0000"
  | Green -> "#00FF00"
  | Blue  -> "#0000FF"

(** [distance p1 p2] returns the Euclidean distance between [p1] and [p2]. *)
let distance p1 p2 =
  let dx = p1.x -. p2.x in
  let dy = p1.y -. p2.y in
  sqrt (dx *. dx +. dy *. dy)

(** [tree_depth t] returns the maximum depth of tree [t] (Leaf has depth 0). *)
let rec tree_depth = function
  | Leaf -> 0
  | Node (l, _, r) -> 1 + max (tree_depth l) (tree_depth r)

(** [tree_insert x t] inserts [x] into BST [t] using the derived compare. *)
let rec tree_insert x = function
  | Leaf -> Node (Leaf, x, Leaf)
  | Node (l, v, r) ->
    let c = compare x v in
    if c < 0 then Node (tree_insert x l, v, r)
    else if c > 0 then Node (l, v, tree_insert x r)
    else Node (l, v, r)
