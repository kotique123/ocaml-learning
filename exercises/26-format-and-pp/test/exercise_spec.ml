open Alcotest

(* Helper: render a formatter function to string *)
let to_string pp x = Format.asprintf "%a" pp x

(* ── Assignment 1: pp_list ─────────────────────────────────────────────── *)

let test_pp_list_empty () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [] in
  check string "empty list" "[]" result

let test_pp_list_ints () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [1; 2; 3] in
  check string "int list" "[1; 2; 3]" result

let test_pp_list_strings () =
  let result = to_string (Exercise.pp_list Format.pp_print_string) ["a"; "b"; "c"] in
  check string "string list" "[a; b; c]" result

let test_pp_list_singleton () =
  let result = to_string (Exercise.pp_list Format.pp_print_int) [42] in
  check string "singleton" "[42]" result

(* ── Assignment 2: pp_tree ─────────────────────────────────────────────── *)

let test_pp_tree_leaf () =
  let result = to_string (Exercise.pp_tree Format.pp_print_int) Exercise.Leaf in
  check string "leaf" "." result

let test_pp_tree_node () =
  let t = Exercise.Node (Exercise.Leaf, 1, Exercise.Leaf) in
  let result = to_string (Exercise.pp_tree Format.pp_print_int) t in
  check string "simple node" "(. 1 .)" result

let test_pp_tree_nested () =
  let t =
    Exercise.Node
      ( Exercise.Node (Exercise.Leaf, 1, Exercise.Leaf),
        2,
        Exercise.Node (Exercise.Leaf, 3, Exercise.Leaf) )
  in
  let result = to_string (Exercise.pp_tree Format.pp_print_int) t in
  check string "nested tree" "((. 1 .) 2 (. 3 .))" result

(* ── Assignment 3: pp_record ────────────────────────────────────────────── *)

let test_pp_record_empty () =
  let result = Format.asprintf "%a" Exercise.pp_record [] in
  check string "empty record" "{  }" result

let test_pp_record_one () =
  let result = Format.asprintf "%a" Exercise.pp_record [("name", "Alice")] in
  check string "one field" "{ name = Alice }" result

let test_pp_record_multi () =
  let result =
    Format.asprintf "%a" Exercise.pp_record [("x", "1"); ("y", "2")]
  in
  check string "two fields" "{ x = 1; y = 2 }" result

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
  check bool "non-empty" true (String.length result > 0);
  List.iter (fun v ->
    check bool ("contains " ^ v) true (contains_sub result v)
  ) (headers @ List.concat rows)

let test_format_table_single_row () =
  let result = Exercise.format_table ["Col"] [["Val"]] in
  check bool "non-empty single" true (String.length result > 0)

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  run "Exercise 26: format-and-pp"
    [ ( "Assignment 1: pp_list",
        [ test_case "empty list" `Quick test_pp_list_empty;
          test_case "int list"   `Quick test_pp_list_ints;
          test_case "string list" `Quick test_pp_list_strings;
          test_case "singleton"  `Quick test_pp_list_singleton ] );
      ( "Assignment 2: pp_tree",
        [ test_case "leaf"        `Quick test_pp_tree_leaf;
          test_case "simple node" `Quick test_pp_tree_node;
          test_case "nested tree" `Quick test_pp_tree_nested ] );
      ( "Assignment 3: pp_record",
        [ test_case "empty"      `Quick test_pp_record_empty;
          test_case "one field"  `Quick test_pp_record_one;
          test_case "two fields" `Quick test_pp_record_multi ] );
      ( "Assignment 4: format_table",
        [ test_case "basic table"  `Quick test_format_table_basic;
          test_case "single row"   `Quick test_format_table_single_row ] ) ]
