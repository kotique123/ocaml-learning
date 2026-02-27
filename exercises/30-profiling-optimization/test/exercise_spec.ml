open Alcotest

(* ── Assignment 1: time_it ──────────────────────────────────────────────── *)

let test_time_it_result () =
  let (result, _elapsed) = Exercise.time_it (fun () -> 1 + 1) in
  check int "correct result" 2 result

let test_time_it_elapsed_nonneg () =
  let (_result, elapsed) = Exercise.time_it (fun () -> ()) in
  check bool "elapsed >= 0" true (elapsed >= 0.0)

let test_time_it_measures_time () =
  let (_result, elapsed) = Exercise.time_it (fun () ->
    Unix.sleepf 0.01) in
  check bool "elapsed >= 0.01" true (elapsed >= 0.001)

(* ── Assignment 2: sum_list_naive ───────────────────────────────────────── *)

let test_sum_naive_empty () =
  check int "empty" 0 (Exercise.sum_list_naive [])

let test_sum_naive_basic () =
  check int "1..5" 15 (Exercise.sum_list_naive [1;2;3;4;5])

let test_sum_naive_single () =
  check int "single" 7 (Exercise.sum_list_naive [7])

let test_sum_naive_negative () =
  check int "negatives" (-6) (Exercise.sum_list_naive [-1;-2;-3])

(* ── Assignment 3: sum_list_fast ───────────────────────────────────────── *)

let test_sum_fast_empty () =
  check int "empty" 0 (Exercise.sum_list_fast [])

let test_sum_fast_basic () =
  check int "1..5" 15 (Exercise.sum_list_fast [1;2;3;4;5])

let test_sum_fast_large () =
  let lst = List.init 10000 (fun i -> i) in
  check int "0..9999" 49995000 (Exercise.sum_list_fast lst)

(* ── Assignment 4: sum_array ────────────────────────────────────────────── *)

let test_sum_array_empty () =
  check int "empty" 0 (Exercise.sum_array [||])

let test_sum_array_basic () =
  check int "basic" 15 (Exercise.sum_array [|1;2;3;4;5|])

let test_sum_array_large () =
  let arr = Array.init 1000 (fun i -> i) in
  check int "0..999" 499500 (Exercise.sum_array arr)

(* ── Assignment 5: float_array_dot ─────────────────────────────────────── *)

let approx_float ~msg expected actual =
  let diff = Float.abs (expected -. actual) in
  check bool msg true (diff < 1e-9)

let test_dot_basic () =
  approx_float ~msg:"[1,2,3]·[4,5,6]"
    32.0
    (Exercise.float_array_dot [|1.0;2.0;3.0|] [|4.0;5.0;6.0|])

let test_dot_zero () =
  approx_float ~msg:"zero vector"
    0.0
    (Exercise.float_array_dot [|1.0;2.0|] [|0.0;0.0|])

let test_dot_unit () =
  approx_float ~msg:"unit dot"
    1.0
    (Exercise.float_array_dot [|1.0;0.0|] [|1.0;0.0|])

let test_dot_empty () =
  approx_float ~msg:"empty arrays"
    0.0
    (Exercise.float_array_dot [||] [||])

(* ── Assignment 6: sieve_of_eratosthenes ───────────────────────────────── *)

let test_sieve_small () =
  check (list int) "primes <= 10" [2;3;5;7]
    (Exercise.sieve_of_eratosthenes 10)

let test_sieve_2 () =
  check (list int) "primes <= 2" [2]
    (Exercise.sieve_of_eratosthenes 2)

let test_sieve_1 () =
  check (list int) "primes <= 1" []
    (Exercise.sieve_of_eratosthenes 1)

let test_sieve_20 () =
  check (list int) "primes <= 20" [2;3;5;7;11;13;17;19]
    (Exercise.sieve_of_eratosthenes 20)

(* ── Assignment 7: merge_sort ───────────────────────────────────────────── *)

let test_merge_sort_empty () =
  check (list int) "empty" [] (Exercise.merge_sort [])

let test_merge_sort_single () =
  check (list int) "single" [1] (Exercise.merge_sort [1])

let test_merge_sort_sorted () =
  check (list int) "already sorted" [1;2;3;4;5]
    (Exercise.merge_sort [1;2;3;4;5])

let test_merge_sort_reverse () =
  check (list int) "reverse" [1;2;3;4;5]
    (Exercise.merge_sort [5;4;3;2;1])

let test_merge_sort_random () =
  check (list int) "random order" [1;2;3;4;5;6]
    (Exercise.merge_sort [3;1;4;1;5;2] |> List.sort_uniq compare)

let test_merge_sort_duplicates () =
  check (list int) "with duplicates" [1;1;2;2;3]
    (Exercise.merge_sort [2;1;3;1;2])

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  run "Exercise 30: profiling-optimization"
    [ ( "Assignment 1: time_it",
        [ test_case "correct result"    `Quick test_time_it_result;
          test_case "elapsed nonneg"    `Quick test_time_it_elapsed_nonneg;
          test_case "measures time"     `Quick test_time_it_measures_time ] );
      ( "Assignment 2: sum_list_naive",
        [ test_case "empty"    `Quick test_sum_naive_empty;
          test_case "basic"    `Quick test_sum_naive_basic;
          test_case "single"   `Quick test_sum_naive_single;
          test_case "negative" `Quick test_sum_naive_negative ] );
      ( "Assignment 3: sum_list_fast",
        [ test_case "empty" `Quick test_sum_fast_empty;
          test_case "basic"  `Quick test_sum_fast_basic;
          test_case "large"  `Quick test_sum_fast_large ] );
      ( "Assignment 4: sum_array",
        [ test_case "empty" `Quick test_sum_array_empty;
          test_case "basic"  `Quick test_sum_array_basic;
          test_case "large"  `Quick test_sum_array_large ] );
      ( "Assignment 5: float_array_dot",
        [ test_case "basic"   `Quick test_dot_basic;
          test_case "zero"    `Quick test_dot_zero;
          test_case "unit"    `Quick test_dot_unit;
          test_case "empty"   `Quick test_dot_empty ] );
      ( "Assignment 6: sieve_of_eratosthenes",
        [ test_case "primes <= 10" `Quick test_sieve_small;
          test_case "primes <= 2"  `Quick test_sieve_2;
          test_case "primes <= 1"  `Quick test_sieve_1;
          test_case "primes <= 20" `Quick test_sieve_20 ] );
      ( "Assignment 7: merge_sort",
        [ test_case "empty"      `Quick test_merge_sort_empty;
          test_case "single"     `Quick test_merge_sort_single;
          test_case "sorted"     `Quick test_merge_sort_sorted;
          test_case "reverse"    `Quick test_merge_sort_reverse;
          test_case "random"     `Quick test_merge_sort_random;
          test_case "duplicates" `Quick test_merge_sort_duplicates ] ) ]
