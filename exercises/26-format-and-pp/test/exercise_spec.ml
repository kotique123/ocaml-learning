(* Helper: render a formatter function to string *)
let to_string pp x = Format.asprintf "%a" pp x

(* ── Assignment 1: pp_list ─────────────────────────────────────────────── *)

let test_pp_list_empty () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [] in
  Alcotest.(check string) "empty list" "[]" result

let test_pp_list_ints () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [1; 2; 3] in
  Alcotest.(check string) "int list" "[1; 2; 3]" result

let test_pp_list_strings () =
  let result = to_string (Exercise.pp_list Format.pp_print_string) ["a"; "b"; "c"] in
  Alcotest.(check string) "string list" "[a; b; c]" result

let test_pp_list_singleton () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [42] in
  Alcotest.(check string) "singleton" "[42]" result

(* ── Assignment 2: pp_tree ─────────────────────────────────────────────── *)

let test_pp_tree_leaf () =
  let result = to_string (Exercise.pp_tree Format.pp_print_int) Exercise.Leaf in
  Alcotest.(check string) "leaf" "." result

let test_pp_tree_node () =
  let t = Exercise.Node (Exercise.Leaf, 1, Exercise.Leaf) in
  let result = to_string (Exercise.pp_tree Format.pp_print_int) t in
  Alcotest.(check string) "simple node" "(. 1 .)" result

let test_pp_tree_nested () =
  let t =
    Exercise.Node
      ( Exercise.Node (Exercise.Leaf, 1, Exercise.Leaf),
        2,
        Exercise.Node (Exercise.Leaf, 3, Exercise.Leaf) )
  in
  let result = to_string (Exercise.pp_tree Format.pp_print_int) t in
  Alcotest.(check string) "nested tree" "((. 1 .) 2 (. 3 .))" result

(* ── Assignment 3: pp_record ────────────────────────────────────────────── *)

let test_pp_record_empty () =
  let result = Format.asprintf "%a" Exercise.pp_record [] in
  Alcotest.(check string) "empty record" "{  }" result

let test_pp_record_one () =
  let result = Format.asprintf "%a" Exercise.pp_record [("name", "Alice")] in
  Alcotest.(check string) "one field" "{ name = Alice }" result

let test_pp_record_multi () =
  let result =
    Format.asprintf "%a" Exercise.pp_record [("x", "1"); ("y", "2")]
  in
  Alcotest.(check string) "two fields" "{ x = 1; y = 2 }" result

(* ── Assignment 4: format_table ─────────────────────────────────────────── *)

let contains_sub s sub =
  let ls = String.length s and lsub = String.length sub in
  if lsub = 0 then true
  else if lsub > ls then false
  else
    let found = ref false in
    for i = 0 to ls - lsub do
      if String.sub s i lsub = sub then found := true
    done;
    !found

let test_format_table_basic () =
  let headers = ["Name"; "Age"] in
  let rows = [["Alice"; "30"]; ["Bob"; "25"]] in
  let result = Exercise.format_table headers rows in
  Alcotest.(check bool) "non-empty" true (String.length result > 0);
  List.iter (fun v ->
    Alcotest.(check bool) ("contains " ^ v) true (contains_sub result v)
  ) (headers @ List.concat rows)

let test_format_table_single_row () =
  let result = Exercise.format_table ["Col"] [["Val"]] in
  Alcotest.(check bool) "non-empty single" true (String.length result > 0)

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  Alcotest.run "Exercise 26 — Format and PP"
    [ ( "Assignment 1: pp_list",
        [ Alcotest.test_case "empty list" `Quick test_pp_list_empty;
          Alcotest.test_case "int list"   `Quick test_pp_list_ints;
          Alcotest.test_case "string list" `Quick test_pp_list_strings;
          Alcotest.test_case "singleton"  `Quick test_pp_list_singleton ] );
      ( "Assignment 2: pp_tree",
        [ Alcotest.test_case "leaf"        `Quick test_pp_tree_leaf;
          Alcotest.test_case "simple node" `Quick test_pp_tree_node;
          Alcotest.test_case "nested tree" `Quick test_pp_tree_nested ] );
      ( "Assignment 3: pp_record",
        [ Alcotest.test_case "empty"      `Quick test_pp_record_empty;
          Alcotest.test_case "one field"  `Quick test_pp_record_one;
          Alcotest.test_case "two fields" `Quick test_pp_record_multi ] );
      ( "Assignment 4: format_table",
        [ Alcotest.test_case "basic table"  `Quick test_format_table_basic;
          Alcotest.test_case "single row"   `Quick test_format_table_single_row ] ) ]
