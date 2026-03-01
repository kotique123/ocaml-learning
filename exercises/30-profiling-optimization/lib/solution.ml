let time_it (f : unit -> 'a) : 'a * float =
  let t0 = Unix.gettimeofday () in
  let result = f () in
  let t1 = Unix.gettimeofday () in
  (result, t1 -. t0)

let sum_list_naive (lst : int list) : int =
  List.fold_right ( + ) lst 0

let sum_list_fast (lst : int list) : int =
  List.fold_left ( + ) 0 lst

let sum_array (arr : int array) : int =
  let s = ref 0 in
  Array.iter (fun x -> s := !s + x) arr;
  !s

let float_array_dot (a : float array) (b : float array) : float =
  let n = min (Array.length a) (Array.length b) in
  let sum = ref 0.0 in
  for i = 0 to n - 1 do sum := !sum +. a.(i) *. b.(i) done;
  !sum

let sieve_of_eratosthenes (n : int) : int list =
  if n < 2 then []
  else begin
    let arr = Array.make (n + 1) true in
    arr.(0) <- false;
    arr.(1) <- false;
    let limit = int_of_float (Float.sqrt (float_of_int n)) in
    for i = 2 to limit do
      if arr.(i) then begin
        let j = ref (i * i) in
        while !j <= n do
          arr.(!j) <- false;
          j := !j + i
        done
      end
    done;
    let result = ref [] in
    for i = n downto 2 do
      if arr.(i) then result := i :: !result
    done;
    !result
  end

let merge_sort (lst : int list) : int list =
  let rec split = function
    | [] | [_] as l -> (l, [])
    | h1 :: h2 :: t ->
      let (a, b) = split t in
      (h1 :: a, h2 :: b)
  in
  let rec merge a b = match (a, b) with
    | [], r | r, [] -> r
    | h1 :: t1, h2 :: t2 ->
      if h1 <= h2 then h1 :: merge t1 b
      else h2 :: merge a t2
  in
  let rec sort = function
    | [] | [_] as l -> l
    | l ->
      let (a, b) = split l in
      merge (sort a) (sort b)
  in
  sort lst
