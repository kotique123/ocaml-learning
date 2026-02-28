exception Division_by_zero_custom of string
exception Out_of_range of { index : int; length : int }

(** [safe_div a b] raises [Division_by_zero_custom "division by zero"] when b = 0, else returns a / b. *)
let safe_div (a : int) (b : int) : int = failwith "not implemented"

(** [safe_nth lst i] raises [Out_of_range {index=i; length=n}] when i is out of bounds.
    Otherwise returns the ith element. *)
let safe_nth (lst : 'a list) (i : int) : 'a = failwith "not implemented"

(** [try_div a b] catches Division_by_zero_custom and returns [Error msg], else [Ok result]. *)
let try_div (a : int) (b : int) : (int, string) result = failwith "not implemented"

(** [with_default default f] runs [f ()], returning its result, or [default] if any exception is raised. *)
let with_default (default : 'a) (f : unit -> 'a) : 'a = failwith "not implemented"

(** [validate_age n] raises [Invalid_argument "age must be 0..150"] if n < 0 or n > 150, else returns n. *)
let validate_age (n : int) : int = failwith "not implemented"
