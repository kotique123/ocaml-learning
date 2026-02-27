(** [force_once v] forces the lazy value [v]. *)
let force_once (_v : 'a lazy_t) : 'a = failwith "not implemented"

(** [memoize f] returns a memoized version of [f] using a Hashtbl cache. *)
let memoize (_f : 'a -> 'b) : 'a -> 'b = failwith "not implemented"

(** [fib_memo n] computes Fibonacci using memoization (efficient for large n). *)
let fib_memo (_n : int) : int = failwith "not implemented"

(** [lazy_range lo hi] returns a lazy Seq.t of integers from [lo] to [hi-1]. *)
let lazy_range (_lo : int) (_hi : int) : int Seq.t = failwith "not implemented"

(** [lazy_filter pred seq] returns a lazy Seq.t of elements satisfying [pred]. *)
let lazy_filter (_pred : 'a -> bool) (_seq : 'a Seq.t) : 'a Seq.t = failwith "not implemented"

(** [lazy_fibs ()] returns an infinite lazy Seq.t of Fibonacci numbers starting 0, 1, 1, 2, 3, 5, ... *)
let lazy_fibs : unit -> int Seq.t = failwith "not implemented"
