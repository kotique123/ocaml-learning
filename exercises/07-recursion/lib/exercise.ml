(** [factorial n] returns n! for n >= 0. *)
let rec factorial (n : int) : int = failwith "not implemented"

(** [fibonacci n] returns the nth Fibonacci number (0-indexed: fib 0=0, fib 1=1). *)
let rec fibonacci (n : int) : int = failwith "not implemented"

(** [my_length lst] returns the length of [lst] using recursion (not List.length). *)
let rec my_length (lst : 'a list) : int = failwith "not implemented"

(** [my_reverse lst] reverses [lst] using recursion (not List.rev). *)
let rec my_reverse (lst : 'a list) : 'a list = failwith "not implemented"

(** [my_map f lst] applies [f] to every element of [lst] (not List.map). *)
let rec my_map (f : 'a -> 'b) (lst : 'a list) : 'b list = failwith "not implemented"

(** [count_down n] returns [[n; n-1; ...; 1; 0]] for n >= 0. *)
let rec count_down (n : int) : int list = failwith "not implemented"

(** [power base exp] computes base^exp for exp >= 0 using recursion. *)
let rec power (base : int) (exp : int) : int = failwith "not implemented"
