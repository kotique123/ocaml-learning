open Effect.Deep

(** A simple logging effect. *)
type _ Effect.t += Log : string -> unit Effect.t

(** [run_with_log f] runs [f ()] capturing all Log effects and returns (result, log_lines). *)
let run_with_log (f : unit -> 'a) : 'a * string list =
  ignore f; failwith "not implemented"

(** A state effect. *)
type _ Effect.t += Get : int Effect.t
type _ Effect.t += Put : int -> unit Effect.t

(** [run_state initial f] runs [f ()] with state starting at [initial].
    Returns (result, final_state). *)
let run_state (initial : int) (f : unit -> 'a) : 'a * int =
  ignore (initial, f); failwith "not implemented"

(** An early-exit (abort) effect. *)
type _ Effect.t += Abort : 'a Effect.t

(** [run_with_abort f default] runs [f ()]; if Abort is performed, returns [default]. *)
let run_with_abort (f : unit -> 'a) (default : 'a) : 'a =
  ignore (f, default); failwith "not implemented"
