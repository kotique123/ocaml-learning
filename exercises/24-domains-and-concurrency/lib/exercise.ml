(** [parallel_map f lst] applies [f] to every element in parallel using Domain.spawn.
    Order of results must match order of input. *)
let parallel_map (f : 'a -> 'b) (lst : 'a list) : 'b list =
  ignore (f, lst); failwith "not implemented"

(** [parallel_sum lst] sums a list using two domains (split in half, sum each half, add). *)
let parallel_sum (lst : int list) : int =
  ignore lst; failwith "not implemented"

(** [thread_safe_counter ()] returns (increment, get) using Mutex for safety. *)
let thread_safe_counter () : (unit -> unit) * (unit -> int) =
  failwith "not implemented"

(** [atomic_counter ()] returns (increment, get) using Atomic (lock-free). *)
let atomic_counter () : (unit -> unit) * (unit -> int) =
  failwith "not implemented"
