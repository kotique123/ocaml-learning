(** [parallel_map f lst] applies [f] to every element in parallel using Domain.spawn.
    Order of results must match order of input. *)
let parallel_map f lst =
  let domains = List.map (fun x -> Domain.spawn (fun () -> f x)) lst in
  List.map Domain.join domains

(** [parallel_sum lst] sums a list using two domains (split in half, sum each half, add). *)
let parallel_sum lst =
  let n = List.length lst in
  if n = 0 then 0
  else
    let mid = n / 2 in
    let rec split i acc = function
      | [] -> (List.rev acc, [])
      | x :: rest ->
        if i < mid then split (i + 1) (x :: acc) rest
        else (List.rev acc, x :: rest)
    in
    let (left, right) = split 0 [] lst in
    let d = Domain.spawn (fun () -> List.fold_left ( + ) 0 right) in
    let left_sum = List.fold_left ( + ) 0 left in
    left_sum + Domain.join d

(** [thread_safe_counter ()] returns (increment, get) using Mutex for safety. *)
let thread_safe_counter () =
  let count = ref 0 in
  let mutex = Mutex.create () in
  let increment () =
    Mutex.lock mutex;
    incr count;
    Mutex.unlock mutex
  in
  let get () =
    Mutex.lock mutex;
    let v = !count in
    Mutex.unlock mutex;
    v
  in
  (increment, get)

(** [atomic_counter ()] returns (increment, get) using Atomic (lock-free). *)
let atomic_counter () =
  let count = Atomic.make 0 in
  let increment () = ignore (Atomic.fetch_and_add count 1) in
  let get () = Atomic.get count in
  (increment, get)
