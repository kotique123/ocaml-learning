(** [sum_naive lst] sums a list naively (NOT tail-recursive — for comparison). *)
let sum_naive (lst : int list) : int = failwith "not implemented"

(** [sum_tr lst] sums a list using tail recursion with an accumulator. *)
let sum_tr (lst : int list) : int = failwith "not implemented"

(** [reverse_tr lst] reverses a list using tail recursion. *)
let reverse_tr (lst : 'a list) : 'a list = failwith "not implemented"

(** [flatten_tr lst] flattens a list of lists using tail recursion. *)
let flatten_tr (lst : 'a list list) : 'a list = failwith "not implemented"

(** [map_tr f lst] maps [f] over [lst] in a tail-recursive way. *)
let map_tr (f : 'a -> 'b) (lst : 'a list) : 'b list = failwith "not implemented"

(** [fibonacci_tr n] computes the nth Fibonacci number using a tail-recursive helper. *)
let fibonacci_tr (n : int) : int = failwith "not implemented"

(** [range lo hi] returns [[lo; lo+1; ...; hi-1]] using tail recursion. *)
let range (lo : int) (hi : int) : int list = failwith "not implemented"
