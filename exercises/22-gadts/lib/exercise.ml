(** A type-safe expression language. *)
type _ expr =
  | Lit_int  : int  -> int expr
  | Lit_bool : bool -> bool expr
  | Add      : int expr * int expr -> int expr
  | If       : bool expr * 'a expr * 'a expr -> 'a expr
  | Eq       : int expr * int expr -> bool expr

(** [eval e] evaluates the expression [e] to its value. *)
let rec eval : type a. a expr -> a =
  fun e -> ignore e; failwith "not implemented"

(** Heterogeneous list (HList). *)
type _ hlist =
  | HNil  : unit hlist
  | HCons : 'a * 'b hlist -> ('a * 'b) hlist

(** [hhead lst] returns the first element of a non-empty HList. *)
let hhead (lst : ('a * 'b) hlist) : 'a =
  ignore lst; failwith "not implemented"

(** [htail lst] returns the tail of a non-empty HList. *)
let htail (lst : ('a * 'b) hlist) : 'b hlist =
  ignore lst; failwith "not implemented"

(** [hlength lst] returns the number of elements (as a regular int). *)
let rec hlength : type a. a hlist -> int =
  fun lst -> ignore lst; failwith "not implemented"
