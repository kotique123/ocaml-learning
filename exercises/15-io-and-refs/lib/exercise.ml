(** [make_counter ()] returns a pair of functions (increment, get_value).
    The counter starts at 0. *)
let make_counter : unit -> (unit -> unit) * (unit -> int) = fun () ->
  failwith "not implemented"

(** [memoize f] returns a memoized version of [f] using a Hashtbl.
    Only works for functions where arguments can be used as hash keys. *)
let memoize (_f : 'a -> 'b) : 'a -> 'b = failwith "not implemented"

(** [read_lines filename] reads all lines from [filename] and returns them as a list.
    Returns an empty list if the file does not exist. *)
let read_lines (_filename : string) : string list = failwith "not implemented"

(** [write_lines filename lines] writes each string in [lines] to [filename], one per line. *)
let write_lines (_filename : string) (_lines : string list) : unit = failwith "not implemented"

(** [running_average ()] returns a pair (add_value, get_average).
    [add_value x] records x; [get_average ()] returns current mean as float. *)
let running_average : unit -> (float -> unit) * (unit -> float) = fun () ->
  failwith "not implemented"
