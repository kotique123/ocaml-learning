(** [time_it f] runs [f ()] and returns (result, elapsed_seconds). *)
let time_it (f : unit -> 'a) : 'a * float = failwith "not implemented"

(** [sum_list_naive lst] sums a list with fold_right (non-tail-recursive). *)
let sum_list_naive (lst : int list) : int = failwith "not implemented"

(** [sum_list_fast lst] sums a list with fold_left (tail-recursive, cache-friendly). *)
let sum_list_fast (lst : int list) : int = failwith "not implemented"

(** [sum_array arr] sums an array with a loop (most cache-friendly). *)
let sum_array (arr : int array) : int = failwith "not implemented"

(** [float_array_dot a b] computes the dot product of two float arrays efficiently.
    Use a for loop, not Array.fold. *)
let float_array_dot (a : float array) (b : float array) : float = failwith "not implemented"

(** [sieve_of_eratosthenes n] returns all primes <= n using a boolean array. *)
let sieve_of_eratosthenes (n : int) : int list = failwith "not implemented"

(** [merge_sort lst] implements merge sort (returns sorted copy, no mutation). *)
let merge_sort (lst : int list) : int list = failwith "not implemented"
