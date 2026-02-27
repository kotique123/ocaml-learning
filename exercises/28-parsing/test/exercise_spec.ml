open Alcotest

let ok_testable (type a) (pp : a Alcotest.testable) =
  Alcotest.result pp Alcotest.string

(* ── Assignment 1: parse_int ────────────────────────────────────────────── *)

let test_parse_int_positive () =
  check (ok_testable int) "positive int" (Ok 42) (Exercise.run Exercise.parse_int "42")

let test_parse_int_negative () =
  check (ok_testable int) "negative int" (Ok (-7)) (Exercise.run Exercise.parse_int "-7")

let test_parse_int_zero () =
  check (ok_testable int) "zero" (Ok 0) (Exercise.run Exercise.parse_int "0")

let test_parse_int_error () =
  let r = Exercise.run Exercise.parse_int "abc" in
  check bool "error on letters" true (Result.is_error r)

(* ── Assignment 2: parse_csv_line ──────────────────────────────────────── *)

let test_csv_simple () =
  check (ok_testable (list string)) "simple csv"
    (Ok ["a";"b";"c"])
    (Exercise.run Exercise.parse_csv_line "a,b,c")

let test_csv_quoted () =
  check (ok_testable (list string)) "quoted field"
    (Ok ["a";"b,c";"d"])
    (Exercise.run Exercise.parse_csv_line {|a,"b,c",d|})

let test_csv_single () =
  check (ok_testable (list string)) "single field"
    (Ok ["hello"])
    (Exercise.run Exercise.parse_csv_line "hello")

let test_csv_empty_fields () =
  check (ok_testable (list string)) "empty fields"
    (Ok ["";"";""]) 
    (Exercise.run Exercise.parse_csv_line ",,")

(* ── Assignment 3: parse_json_bool ─────────────────────────────────────── *)

let test_json_bool_true () =
  check (ok_testable bool) "true" (Ok true)
    (Exercise.run Exercise.parse_json_bool "true")

let test_json_bool_false () =
  check (ok_testable bool) "false" (Ok false)
    (Exercise.run Exercise.parse_json_bool "false")

let test_json_bool_error () =
  let r = Exercise.run Exercise.parse_json_bool "yes" in
  check bool "error on yes" true (Result.is_error r)

(* ── Assignment 4: parse_list_of_ints ──────────────────────────────────── *)

let test_list_ints_basic () =
  check (ok_testable (list int)) "basic list"
    (Ok [1;2;3])
    (Exercise.run Exercise.parse_list_of_ints "[1, 2, 3]")

let test_list_ints_empty () =
  check (ok_testable (list int)) "empty list"
    (Ok [])
    (Exercise.run Exercise.parse_list_of_ints "[]")

let test_list_ints_single () =
  check (ok_testable (list int)) "single element"
    (Ok [99])
    (Exercise.run Exercise.parse_list_of_ints "[99]")

let test_list_ints_negative () =
  check (ok_testable (list int)) "negative ints"
    (Ok [-1; 2; -3])
    (Exercise.run Exercise.parse_list_of_ints "[-1, 2, -3]")

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  run "Exercise 28: parsing"
    [ ( "Assignment 1: parse_int",
        [ test_case "positive"  `Quick test_parse_int_positive;
          test_case "negative"  `Quick test_parse_int_negative;
          test_case "zero"      `Quick test_parse_int_zero;
          test_case "error"     `Quick test_parse_int_error ] );
      ( "Assignment 2: parse_csv_line",
        [ test_case "simple"        `Quick test_csv_simple;
          test_case "quoted field"  `Quick test_csv_quoted;
          test_case "single field"  `Quick test_csv_single;
          test_case "empty fields"  `Quick test_csv_empty_fields ] );
      ( "Assignment 3: parse_json_bool",
        [ test_case "true"   `Quick test_json_bool_true;
          test_case "false"  `Quick test_json_bool_false;
          test_case "error"  `Quick test_json_bool_error ] );
      ( "Assignment 4: parse_list_of_ints",
        [ test_case "basic list"    `Quick test_list_ints_basic;
          test_case "empty list"    `Quick test_list_ints_empty;
          test_case "single elem"   `Quick test_list_ints_single;
          test_case "negative ints" `Quick test_list_ints_negative ] ) ]
