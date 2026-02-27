(** [apply f x] applies function [f] to [x]. *)
let apply (_f : 'a -> 'b) (_x : 'a) : 'b = failwith "not implemented"

(** [compose f g x] applies [g] then [f]: equivalent to (f ∘ g)(x). *)
let compose (_f : 'b -> 'c) (_g : 'a -> 'b) (_x : 'a) : 'c = failwith "not implemented"

(** [flip f x y] flips the first two arguments of [f]. *)
let flip (_f : 'a -> 'b -> 'c) (_x : 'b) (_y : 'a) : 'c = failwith "not implemented"

(** [add x y] returns [x + y]. Used to demonstrate partial application. *)
let add (_x : int) (_y : int) : int = failwith "not implemented"

(** [pipeline x fns] applies a list of functions [fns] to [x] in sequence using |>. *)
let pipeline (_x : int) (_fns : (int -> int) list) : int = failwith "not implemented"

(** [twice f x] applies [f] to [x] twice: f (f x). *)
let twice (_f : 'a -> 'a) (_x : 'a) : 'a = failwith "not implemented"
