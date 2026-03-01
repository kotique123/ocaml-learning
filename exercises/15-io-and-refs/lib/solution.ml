let make_counter : unit -> (unit -> unit) * (unit -> int) =
 fun () ->
  let count = ref 0 in
  let increment () = incr count in
  let get () = !count in
  (increment, get)

let memoize (f : 'a -> 'b) : 'a -> 'b =
  let tbl = Hashtbl.create 16 in
  fun x ->
    match Hashtbl.find_opt tbl x with
    | Some v -> v
    | None ->
      let v = f x in
      Hashtbl.add tbl x v;
      v

let read_lines (filename : string) : string list =
  try
    let ic = open_in filename in
    let lines = ref [] in
    (try
       while true do
         lines := input_line ic :: !lines
       done
     with End_of_file -> ());
    close_in ic;
    List.rev !lines
  with Sys_error _ -> []

let write_lines (filename : string) (lines : string list) : unit =
  let oc = open_out filename in
  List.iter
    (fun line ->
      output_string oc line;
      output_char oc '\n')
    lines;
  close_out oc

let running_average : unit -> (float -> unit) * (unit -> float) =
 fun () ->
  let sum = ref 0.0 in
  let count = ref 0 in
  let add x =
    sum := !sum +. x;
    incr count
  in
  let avg () =
    if !count = 0 then 0.0 else !sum /. float_of_int !count
  in
  (add, avg)
