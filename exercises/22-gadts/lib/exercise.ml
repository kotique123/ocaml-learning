(** A type-safe expression language. *)
type _ expr =
  | Lit_int  : int  -> int expr
  | Lit_bool : bool -> bool expr
  | Add      : int expr * int expr -> int expr
  | If       : bool expr * 'a expr * 'a expr -> 'a expr
  | Eq       : int expr * int expr -> bool expr

(** [eval e] evaluates the expression [e] to its value. *)
let rec eval : type a. a expr -> a = function
  | Lit_int n  -> n
  | Lit_bool b -> b
  | Add (e1, e2) -> eval e1 + eval e2
  | If (cond, e_then, e_else) -> if eval cond then eval e_then else eval e_else
  | Eq (e1, e2) -> eval e1 = eval e2

(** Heterogeneous list (HList). *)
type _ hlist =
  | HNil  : unit hlist
  | HCons : 'a * 'b hlist -> ('a * 'b) hlist

(** [hhead lst] returns the first element of a non-empty HList. *)
let hhead (HCons (x, _)) = x

(** [htail lst] returns the tail of a non-empty HList. *)
let htail (HCons (_, rest)) = rest

(** [hlength lst] returns the number of elements (as a regular int). *)
let rec hlength : type a. a hlist -> int = function
  | HNil -> 0
  | HCons (_, rest) -> 1 + hlength rest
