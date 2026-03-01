type direction = North | South | East | West

let opposite (d : direction) : direction =
  match d with
  | North -> South
  | South -> North
  | East -> West
  | West -> East

let is_horizontal (d : direction) : bool =
  match d with
  | East | West -> true
  | _ -> false

type shape = Circle of float | Rectangle of float * float | Triangle of float * float * float

let area (s : shape) : float =
  match s with
  | Circle r -> Float.pi *. r *. r
  | Rectangle (w, h) -> w *. h
  | Triangle (a, b, c) ->
    let s = (a +. b +. c) /. 2.0 in
    Float.sqrt (s *. (s -. a) *. (s -. b) *. (s -. c))

let perimeter (s : shape) : float =
  match s with
  | Circle r -> 2.0 *. Float.pi *. r
  | Rectangle (w, h) -> 2.0 *. (w +. h)
  | Triangle (a, b, c) -> a +. b +. c

type person = { name : string; age : int; email : string }

let make_person (name : string) (age : int) (email : string) : person =
  { name; age; email }

let is_adult (p : person) : bool = p.age >= 18

let birthday (p : person) : person = { p with age = p.age + 1 }
