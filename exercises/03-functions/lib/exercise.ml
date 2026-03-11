(** [apply f x] applies function [f] to [x]. *)
let apply (f : 'a -> 'b) (x : 'a) : 'b = f @@ x

(** [compose f g x] applies [g] then [f]: equivalent to (f ∘ g)(x). *)
let compose (f : 'b -> 'c) (g : 'a -> 'b) (x : 'a) : 'c = f @@ g @@ x

(** [flip f x y] flips the first two arguments of [f]. *)
let flip (f : 'a -> 'b -> 'c) (x : 'b) (y : 'a) : 'c = f y x

(** [add x y] returns [x + y]. Used to demonstrate partial application. *)
let add (x : int) (y : int) : int = x + y

(** [pipeline x fns] applies a list of functions [fns] to [x] in sequence using |>. *)
let pipeline (x : int) (fns : (int -> int) list) : int = 
  List.fold_left(fun acc fn -> fn acc) x fns

(** [twice f x] applies [f] to [x] twice: f (f x). *)
let twice (f : 'a -> 'a) (x : 'a) : 'a = f @@ f x
