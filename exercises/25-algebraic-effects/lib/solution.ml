open Effect.Deep

(** A simple logging effect. *)
type _ Effect.t += Log : string -> unit Effect.t

(** [run_with_log f] runs [f ()] capturing all Log effects and returns (result, log_lines). *)
let run_with_log f =
  let logs = ref [] in
  let result =
    match_with f ()
      { retc = (fun v -> v);
        exnc = raise;
        effc = fun (type a) (eff : a Effect.t) ->
          match eff with
          | Log msg ->
            Some (fun (k : (a, _) continuation) ->
              logs := !logs @ [msg];
              continue k ())
          | _ -> None }
  in
  (result, !logs)

(** A state effect. *)
type _ Effect.t += Get : int Effect.t
type _ Effect.t += Put : int -> unit Effect.t

(** [run_state initial f] runs [f ()] with state starting at [initial].
    Returns (result, final_state). *)
let run_state (initial : int) f =
  let state = ref initial in
  let result =
    match_with f ()
      { retc = (fun v -> v);
        exnc = raise;
        effc = fun (type a) (eff : a Effect.t) ->
          match eff with
          | Get ->
            Some (fun (k : (a, _) continuation) ->
              continue k !state)
          | Put v ->
            Some (fun (k : (a, _) continuation) ->
              state := v;
              continue k ())
          | _ -> None }
  in
  (result, !state)

(** An early-exit (abort) effect. *)
type _ Effect.t += Abort : 'a Effect.t

(** [run_with_abort f default] runs [f ()]; if Abort is performed, returns [default]. *)
let run_with_abort f default =
  match_with f ()
    { retc = (fun v -> v);
      exnc = raise;
      effc = fun (type a) (eff : a Effect.t) ->
        match eff with
        | Abort -> Some (fun (_k : (a, _) continuation) -> default)
        | _ -> None }
