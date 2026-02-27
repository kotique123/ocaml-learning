open Alcotest

(* ── Assignment 1: force_once ───────────────────────────────────────────── *)

let test_force_int () =
  let v = lazy 42 in
  check int "force int" 42 (Exercise.force_once v)

let test_force_string () =
  let v = lazy "hello" in
  check string "force string" "hello" (Exercise.force_once v)

let test_force_evaluates_once () =
  let count = ref 0 in
  let v = lazy (incr count; !count) in
  let _ = Exercise.force_once v in
  let _ = Exercise.force_once v in
  (* Lazy.force caches result — side effect runs only once *)
  check int "evaluated once" 1 !count

(* ── Assignment 2: memoize ──────────────────────────────────────────────── *)

let test_memoize_result () =
  let f = Exercise.memoize (fun x -> x * 2) in
  check int "double 5"  10 (f 5);
  check int "double 10" 20 (f 10)

let test_memoize_caches () =
  let count = ref 0 in
  let f = Exercise.memoize (fun x -> incr count; x + 1) in
  let _ = f 7 in
  let _ = f 7 in
  check int "called once" 1 !count

let test_memoize_different_keys () =
  let count = ref 0 in
  let f = Exercise.memoize (fun x -> incr count; x * x) in
  check int "sq 3" 9  (f 3);
  check int "sq 4" 16 (f 4);
  check int "count" 2 !count

(* ── Assignment 3: fib_memo ─────────────────────────────────────────────── *)

let test_fib_base () =
  check int "fib 0" 0 (Exercise.fib_memo 0);
  check int "fib 1" 1 (Exercise.fib_memo 1)

let test_fib_small () =
  check int "fib 5"  5  (Exercise.fib_memo 5);
  check int "fib 10" 55 (Exercise.fib_memo 10)

let test_fib_large () =
  check int "fib 30" 832040 (Exercise.fib_memo 30)

(* ── Assignment 4: lazy_range ───────────────────────────────────────────── *)

let test_lazy_range_basic () =
  let lst = Exercise.lazy_range 0 5 |> List.of_seq in
  check (list int) "range 0..4" [0;1;2;3;4] lst

let test_lazy_range_empty () =
  let lst = Exercise.lazy_range 3 3 |> List.of_seq in
  check (list int) "empty range" [] lst

let test_lazy_range_partial () =
  let lst = Exercise.lazy_range 2 6 |> List.of_seq in
  check (list int) "range 2..5" [2;3;4;5] lst

(* ── Assignment 5: lazy_filter ─────────────────────────────────────────── *)

let test_lazy_filter_evens () =
  let seq = Exercise.lazy_range 0 10 in
  let evens = Exercise.lazy_filter (fun x -> x mod 2 = 0) seq |> List.of_seq in
  check (list int) "evens 0-9" [0;2;4;6;8] evens

let test_lazy_filter_none () =
  let seq = Exercise.lazy_range 0 5 in
  let result = Exercise.lazy_filter (fun _ -> false) seq |> List.of_seq in
  check (list int) "filter none" [] result

let test_lazy_filter_all () =
  let seq = Exercise.lazy_range 1 4 in
  let result = Exercise.lazy_filter (fun _ -> true) seq |> List.of_seq in
  check (list int) "filter all" [1;2;3] result

(* ── Assignment 6: lazy_fibs ───────────────────────────────────────────── *)

let test_lazy_fibs_first_eight () =
  let fibs = Exercise.lazy_fibs () |> Seq.take 8 |> List.of_seq in
  check (list int) "first 8 fibs" [0;1;1;2;3;5;8;13] fibs

let test_lazy_fibs_is_lazy () =
  (* Just taking a prefix should not diverge *)
  let first = Exercise.lazy_fibs () |> Seq.take 1 |> List.of_seq in
  check (list int) "first fib" [0] first

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  run "Exercise 27: lazy-and-memoization"
    [ ( "Assignment 1: force_once",
        [ test_case "force int"     `Quick test_force_int;
          test_case "force string"  `Quick test_force_string;
          test_case "eval once"     `Quick test_force_evaluates_once ] );
      ( "Assignment 2: memoize",
        [ test_case "correct result"    `Quick test_memoize_result;
          test_case "caches calls"      `Quick test_memoize_caches;
          test_case "different keys"    `Quick test_memoize_different_keys ] );
      ( "Assignment 3: fib_memo",
        [ test_case "base cases"  `Quick test_fib_base;
          test_case "small n"     `Quick test_fib_small;
          test_case "large n"     `Quick test_fib_large ] );
      ( "Assignment 4: lazy_range",
        [ test_case "basic range"   `Quick test_lazy_range_basic;
          test_case "empty range"   `Quick test_lazy_range_empty;
          test_case "partial range" `Quick test_lazy_range_partial ] );
      ( "Assignment 5: lazy_filter",
        [ test_case "filter evens" `Quick test_lazy_filter_evens;
          test_case "filter none"  `Quick test_lazy_filter_none;
          test_case "filter all"   `Quick test_lazy_filter_all ] );
      ( "Assignment 6: lazy_fibs",
        [ test_case "first 8 fibs"  `Quick test_lazy_fibs_first_eight;
          test_case "is lazy"       `Quick test_lazy_fibs_is_lazy ] ) ]
