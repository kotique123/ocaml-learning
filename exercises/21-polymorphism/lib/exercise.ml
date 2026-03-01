(** A type-safe stack using phantom types to distinguish empty from non-empty stacks. *)
type empty = Empty
type nonempty = Nonempty

type (_, 'a) typed_stack =
  | Empty_stack : (empty, 'a) typed_stack
  | Push : 'a * (_, 'a) typed_stack -> (nonempty, 'a) typed_stack

(** [push x s] pushes [x] onto stack [s]. *)
let push (x : 'a) (s : (_, 'a) typed_stack) : (nonempty, 'a) typed_stack =
  ignore (x, s); failwith "not implemented"

(** [top s] returns the top element of a non-empty stack (guaranteed safe). *)
let top (s : (nonempty, 'a) typed_stack) : 'a =
  ignore s; failwith "not implemented"

(** Existential wrapper that hides the emptiness phantom of the remainder after [pop]. *)
type 'a packed_stack = Pack : (_, 'a) typed_stack -> 'a packed_stack

(** [pop s] returns the top element and the remaining stack (packed existential). *)
let pop (s : (nonempty, 'a) typed_stack) : 'a * 'a packed_stack =
  ignore s; failwith "not implemented"

(** A length-indexed list (vector) using phantom types. *)
type zero = Zero
type 'n succ = Succ of 'n

type (_, 'a) vec =
  | VNil : (zero, 'a) vec
  | VCons : 'a * ('n, 'a) vec -> ('n succ, 'a) vec

(** [vhead v] returns the head of a non-empty vec (type-safe). *)
let vhead (v : ('n succ, 'a) vec) : 'a =
  ignore v; failwith "not implemented"

(** [vtail v] returns the tail of a non-empty vec. *)
let vtail (v : ('n succ, 'a) vec) : ('n, 'a) vec =
  ignore v; failwith "not implemented"

(** [vec_to_list v] converts a vec to a regular list. *)
let rec vec_to_list : type n. (n, 'a) vec -> 'a list =
  fun v -> ignore v; failwith "not implemented"
