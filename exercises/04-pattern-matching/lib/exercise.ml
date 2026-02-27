(** [describe_int n] returns "negative", "zero", or "positive". *)
let describe_int (_n : int) : string = failwith "not implemented"

(** [fst_of_triple (a, _, _)] returns the first element of a 3-tuple. *)
let fst_of_triple (_t : 'a * 'b * 'c) : 'a = failwith "not implemented"

(** [classify_pair (a, b)] returns "both zero", "first zero", "second zero", or "neither zero". *)
let classify_pair (_p : int * int) : string = failwith "not implemented"

type shape = Circle of float | Rectangle of float * float | Triangle of float * float * float

(** [area s] computes the area of shape [s].
    Circle r -> Float.pi *. r *. r
    Rectangle w h -> w *. h
    Triangle a b c -> Heron's formula: s=(a+b+c)/2, area=sqrt(s*(s-a)*(s-b)*(s-c)) *)
let area (_s : shape) : float = failwith "not implemented"

(** [is_right_triangle a b c] returns true if the triangle with sides a, b, c is a right triangle.
    Assumes c is the hypotenuse. Use: Float.abs (a*.a +. b*.b -. c*.c) < 1e-9 *)
let is_right_triangle (_a : float) (_b : float) (_c : float) : bool = failwith "not implemented"
