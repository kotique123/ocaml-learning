module StringMap = Map.Make (String)
module IntSet = Set.Make (Int)
module IntMap = Map.Make (Int)

(** [word_count words] returns a StringMap from word -> count. *)
let word_count (_words : string list) : int StringMap.t = failwith "not implemented"

(** [most_frequent map] returns Some (word, count) for the highest count, or None if empty. *)
let most_frequent (_map : int StringMap.t) : (string * int) option = failwith "not implemented"

(** [unique_ints lst] returns an IntSet of unique integers from [lst]. *)
let unique_ints (_lst : int list) : IntSet.t = failwith "not implemented"

(** [intersection_count s1 s2] returns the number of elements in the intersection of [s1] and [s2]. *)
let intersection_count (_s1 : IntSet.t) (_s2 : IntSet.t) : int = failwith "not implemented"

(** [invert_map m] swaps keys and values: StringMap int -> IntMap string.
    If duplicate values exist, keep any one. *)
let invert_map (_m : int StringMap.t) : string IntMap.t = failwith "not implemented"
