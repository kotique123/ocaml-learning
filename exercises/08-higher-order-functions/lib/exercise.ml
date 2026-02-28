(** [my_fold_left f acc lst] reimplements List.fold_left using recursion. *)
let rec my_fold_left (f : 'acc -> 'a -> 'acc) (acc : 'acc) (lst : 'a list) : 'acc =
  failwith "not implemented"

(** [compose f g x] returns f (g x). *)
let compose (f : 'b -> 'c) (g : 'a -> 'b) (x : 'a) : 'c = failwith "not implemented"

(** [apply_twice f x] applies [f] to [x] twice. *)
let apply_twice (f : 'a -> 'a) (x : 'a) : 'a = failwith "not implemented"

(** [count_if pred lst] counts elements satisfying predicate [pred]. *)
let count_if (pred : 'a -> bool) (lst : 'a list) : int = failwith "not implemented"

(** [flat_map f lst] maps [f] over [lst] and flattens the result (like List.concat_map). *)
let flat_map (f : 'a -> 'b list) (lst : 'a list) : 'b list = failwith "not implemented"

(** [partition_by pred lst] returns a pair (matching, not_matching). *)
let partition_by (pred : 'a -> bool) (lst : 'a list) : 'a list * 'a list =
  failwith "not implemented"

(** [group_by n lst] groups [lst] into consecutive chunks of size [n].
    Last chunk may be smaller. E.g. group_by 2 [1;2;3;4;5] = [[1;2];[3;4];[5]] *)
let group_by (n : int) (lst : 'a list) : 'a list list = failwith "not implemented"
