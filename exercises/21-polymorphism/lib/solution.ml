(** A type-safe stack using phantom types to distinguish empty from non-empty stacks. *)
type empty = Empty
type nonempty = Nonempty

type (_, 'a) typed_stack =
  | Empty_stack : (empty, 'a) typed_stack
  | Push : 'a * (_, 'a) typed_stack -> (nonempty, 'a) typed_stack

(** [push x s] pushes [x] onto stack [s]. *)
let push x s = Push (x, s)

(** [top s] returns the top element of a non-empty stack (guaranteed safe). *)
let top (Push (x, _)) = x

(** Existential wrapper that hides the emptiness phantom of the remainder after [pop]. *)
type 'a packed_stack = Pack : (_, 'a) typed_stack -> 'a packed_stack

(** [pop s] returns the top element and the remaining stack (packed existential). *)
let pop (Push (x, rest)) = (x, Pack rest)

(** A length-indexed list (vector) using phantom types. *)
type zero = Zero
type 'n succ = Succ of 'n

type (_, 'a) vec =
  | VNil : (zero, 'a) vec
  | VCons : 'a * ('n, 'a) vec -> ('n succ, 'a) vec

(** [vhead v] returns the head of a non-empty vec (type-safe). *)
let vhead (VCons (x, _)) = x

(** [vtail v] returns the tail of a non-empty vec. *)
let vtail (VCons (_, rest)) = rest

(** [vec_to_list v] converts a vec to a regular list. *)
let rec vec_to_list : type n. (n, 'a) vec -> 'a list = function
  | VNil -> []
  | VCons (x, rest) -> x :: vec_to_list rest
