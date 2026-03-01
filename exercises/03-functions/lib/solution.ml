let apply (f : 'a -> 'b) (x : 'a) : 'b = f x
let compose (f : 'b -> 'c) (g : 'a -> 'b) (x : 'a) : 'c = f (g x)
let flip (f : 'a -> 'b -> 'c) (x : 'b) (y : 'a) : 'c = f y x
let add (x : int) (y : int) : int = x + y
let pipeline (x : int) (fns : (int -> int) list) : int = List.fold_left (fun acc f -> f acc) x fns
let twice (f : 'a -> 'a) (x : 'a) : 'a = f (f x)
