type direction = North | South | East | West

(** [opposite d] returns the opposite direction. *)
let opposite (d : direction) : direction = failwith "not implemented"

(** [is_horizontal d] returns true if [d] is East or West. *)
let is_horizontal (d : direction) : bool = failwith "not implemented"

type shape = Circle of float | Rectangle of float * float | Triangle of float * float * float

(** [area s] computes the area of [s]. Use Float.pi for circles. Heron's formula for triangles. *)
let area (s : shape) : float = failwith "not implemented"

(** [perimeter s] computes the perimeter of [s]. *)
let perimeter (s : shape) : float = failwith "not implemented"

type person = { name : string; age : int; email : string }

(** [make_person name age email] creates a person record. *)
let make_person (name : string) (age : int) (email : string) : person =
  failwith "not implemented"

(** [is_adult p] returns true if p.age >= 18. *)
let is_adult (p : person) : bool = failwith "not implemented"

(** [birthday p] returns a new person record with age incremented by 1. *)
let birthday (p : person) : person = failwith "not implemented"
