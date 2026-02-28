module IntMap = Map.Make(Int)
module StringSet = Set.Make(String)

(** [frequency_map lst] returns an IntMap from element -> count. *)
let frequency_map (lst : int list) : int IntMap.t = failwith "not implemented"

(** [top_n n map] returns the [n] entries with highest values from [map] as a sorted list
    (sorted by value descending, then by key ascending for ties). *)
let top_n (n : int) (map : int IntMap.t) : (int * int) list = failwith "not implemented"

(** Binary search tree *)
type 'a bst = Leaf | Node of 'a bst * 'a * 'a bst

(** [bst_insert x t] inserts [x] into BST [t]. *)
let bst_insert (x : 'a) (t : 'a bst) : 'a bst = failwith "not implemented"

(** [bst_mem x t] returns true if [x] is in BST [t]. *)
let bst_mem (x : 'a) (t : 'a bst) : bool = failwith "not implemented"

(** [bst_to_sorted_list t] returns all elements of [t] in sorted order (in-order traversal). *)
let bst_to_sorted_list (t : 'a bst) : 'a list = failwith "not implemented"

(** [anagram_groups words] groups [words] by their sorted character signature.
    Returns a StringMap from signature -> list of words. *)
module StringMap = Map.Make(String)
let anagram_groups (words : string list) : string list StringMap.t = failwith "not implemented"
