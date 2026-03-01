let describe_int (n : int) : string =
  match n with
  | 0 -> "zero"
  | n when n > 0 -> "positive"
  | _ -> "negative"

let fst_of_triple (t : 'a * 'b * 'c) : 'a =
  let (a, _, _) = t in a

let classify_pair (p : int * int) : string =
  match p with
  | (0, 0) -> "both zero"
  | (0, _) -> "first zero"
  | (_, 0) -> "second zero"
  | _ -> "neither zero"

type shape = Circle of float | Rectangle of float * float | Triangle of float * float * float

let area (s : shape) : float =
  match s with
  | Circle r -> Float.pi *. r *. r
  | Rectangle (w, h) -> w *. h
  | Triangle (a, b, c) ->
    let s = (a +. b +. c) /. 2.0 in
    Float.sqrt (s *. (s -. a) *. (s -. b) *. (s -. c))

let is_right_triangle (a : float) (b : float) (c : float) : bool =
  Float.abs (a *. a +. b *. b -. c *. c) < 1e-9
