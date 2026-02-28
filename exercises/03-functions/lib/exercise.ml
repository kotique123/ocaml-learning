(** [apply f x] applies function [f] to [x]. *)
let apply (f : 'a -> 'b) (x : 'a) : 'b = failwith "not implemented"

(** [compose f g x] applies [g] then [f]: equivalent to (f ∘ g)(x). *)
let compose (f : 'b -> 'c) (g : 'a -> 'b) (x : 'a) : 'c = failwith "not implemented"

(** [flip f x y] flips the first two arguments of [f]. *)
let flip (f : 'a -> 'b -> 'c) (x : 'b) (y : 'a) : 'c = failwith "not implemented"

(** [add x y] returns [x + y]. Used to demonstrate partial application. *)
let add (x : int) (y : int) : int = failwith "not implemented"

(** [pipeline x fns] applies a list of functions [fns] to [x] in sequence using |>. *)
let pipeline (x : int) (fns : (int -> int) list) : int = failwith "not implemented"

(** [twice f x] applies [f] to [x] twice: f (f x). *)
let twice (f : 'a -> 'a) (x : 'a) : 'a = failwith "not implemented"
