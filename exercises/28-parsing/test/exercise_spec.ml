let ok_testable (type a) (pp : a Alcotest.testable) =
  Alcotest.result pp Alcotest.string

(* ── Assignment 1: parse_int ────────────────────────────────────────────── *)

let test_parse_int_positive () =
  Alcotest.(check (ok_testable int)) "positive int" (Ok 42) (Exercise.run Exercise.parse_int "42")

let test_parse_int_negative () =
  Alcotest.(check (ok_testable int)) "negative int" (Ok (-7)) (Exercise.run Exercise.parse_int "-7")

let test_parse_int_zero () =
  Alcotest.(check (ok_testable int)) "zero" (Ok 0) (Exercise.run Exercise.parse_int "0")

let test_parse_int_error () =
  let r = Exercise.run Exercise.parse_int "abc" in
  Alcotest.(check bool) "error on letters" true (Result.is_error r)

(* ── Assignment 2: parse_csv_line ──────────────────────────────────────── *)

let test_csv_simple () =
  Alcotest.(check (ok_testable (list string))) "simple csv"
    (Ok ["a";"b";"c"])
    (Exercise.run Exercise.parse_csv_line "a,b,c")

let test_csv_quoted () =
  Alcotest.(check (ok_testable (list string))) "quoted field"
    (Ok ["a";"b,c";"d"])
    (Exercise.run Exercise.parse_csv_line {|a,"b,c",d|})

let test_csv_single () =
  Alcotest.(check (ok_testable (list string))) "single field"
    (Ok ["hello"])
    (Exercise.run Exercise.parse_csv_line "hello")

let test_csv_empty_fields () =
  Alcotest.(check (ok_testable (list string))) "empty fields"
    (Ok ["";"";""]) 
    (Exercise.run Exercise.parse_csv_line ",,")

(* ── Assignment 3: parse_json_bool ─────────────────────────────────────── *)

let test_json_bool_true () =
  Alcotest.(check (ok_testable bool)) "true" (Ok true)
    (Exercise.run Exercise.parse_json_bool "true")

let test_json_bool_false () =
  Alcotest.(check (ok_testable bool)) "false" (Ok false)
    (Exercise.run Exercise.parse_json_bool "false")

let test_json_bool_error () =
  let r = Exercise.run Exercise.parse_json_bool "yes" in
  Alcotest.(check bool) "error on yes" true (Result.is_error r)

(* ── Assignment 4: parse_list_of_ints ──────────────────────────────────── *)

let test_list_ints_basic () =
  Alcotest.(check (ok_testable (list int))) "basic list"
    (Ok [1;2;3])
    (Exercise.run Exercise.parse_list_of_ints "[1, 2, 3]")

let test_list_ints_empty () =
  Alcotest.(check (ok_testable (list int))) "empty list"
    (Ok [])
    (Exercise.run Exercise.parse_list_of_ints "[]")

let test_list_ints_single () =
  Alcotest.(check (ok_testable (list int))) "single element"
    (Ok [99])
    (Exercise.run Exercise.parse_list_of_ints "[99]")

let test_list_ints_negative () =
  Alcotest.(check (ok_testable (list int))) "negative ints"
    (Ok [-1; 2; -3])
    (Exercise.run Exercise.parse_list_of_ints "[-1, 2, -3]")

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  Alcotest.run "Exercise 28 — Parsing"
    [ ( "Assignment 1: parse_int",
        [ Alcotest.test_case "positive"  `Quick test_parse_int_positive;
          Alcotest.test_case "negative"  `Quick test_parse_int_negative;
          Alcotest.test_case "zero"      `Quick test_parse_int_zero;
          Alcotest.test_case "error"     `Quick test_parse_int_error ] );
      ( "Assignment 2: parse_csv_line",
        [ Alcotest.test_case "simple"        `Quick test_csv_simple;
          Alcotest.test_case "quoted field"  `Quick test_csv_quoted;
          Alcotest.test_case "single field"  `Quick test_csv_single;
          Alcotest.test_case "empty fields"  `Quick test_csv_empty_fields ] );
      ( "Assignment 3: parse_json_bool",
        [ Alcotest.test_case "true"   `Quick test_json_bool_true;
          Alcotest.test_case "false"  `Quick test_json_bool_false;
          Alcotest.test_case "error"  `Quick test_json_bool_error ] );
      ( "Assignment 4: parse_list_of_ints",
        [ Alcotest.test_case "basic list"    `Quick test_list_ints_basic;
          Alcotest.test_case "empty list"    `Quick test_list_ints_empty;
          Alcotest.test_case "single elem"   `Quick test_list_ints_single;
          Alcotest.test_case "negative ints" `Quick test_list_ints_negative ] ) ]
