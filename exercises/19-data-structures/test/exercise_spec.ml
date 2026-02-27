let int_map_to_list m =
  Exercise.IntMap.bindings m

let string_map_to_sorted m =
  Exercise.StringMap.bindings m
  |> List.map (fun (k, vs) -> (k, List.sort String.compare vs))
  |> List.sort compare

let () =
  Alcotest.run "Exercise 19 — Data Structures"
    [ ( "Assignment 1: frequency_map",
        [ Alcotest.test_case "counts frequencies" `Quick (fun () ->
              let m = Exercise.frequency_map [1;2;1;3;2;1] in
              Alcotest.(check (list (pair int int))) "frequencies"
                [(1,3);(2,2);(3,1)] (int_map_to_list m));
          Alcotest.test_case "empty list" `Quick (fun () ->
              let m = Exercise.frequency_map [] in
              Alcotest.(check (list (pair int int))) "empty" [] (int_map_to_list m));
          Alcotest.test_case "single element" `Quick (fun () ->
              let m = Exercise.frequency_map [42] in
              Alcotest.(check (list (pair int int))) "one" [(42,1)] (int_map_to_list m)) ] );
      ( "Assignment 2: top_n",
        [ Alcotest.test_case "top 2 of 3" `Quick (fun () ->
              let m = Exercise.IntMap.of_list [(1,10);(2,30);(3,20)] in
              let result = Exercise.top_n 2 m in
              Alcotest.(check (list (pair int int))) "top 2"
                [(2,30);(3,20)] result);
          Alcotest.test_case "top 0 returns empty" `Quick (fun () ->
              let m = Exercise.IntMap.of_list [(1,5);(2,3)] in
              Alcotest.(check (list (pair int int))) "empty" [] (Exercise.top_n 0 m));
          Alcotest.test_case "n larger than map returns all sorted" `Quick (fun () ->
              let m = Exercise.IntMap.of_list [(1,5);(2,3);(3,8)] in
              let result = Exercise.top_n 10 m in
              Alcotest.(check (list (pair int int))) "all sorted desc"
                [(3,8);(1,5);(2,3)] result) ] );
      ( "Assignment 3: bst_insert and bst_mem",
        [ Alcotest.test_case "mem finds inserted element" `Quick (fun () ->
              let t = Exercise.bst_insert 5 Exercise.Leaf in
              Alcotest.(check bool) "found 5" true (Exercise.bst_mem 5 t));
          Alcotest.test_case "mem returns false for absent element" `Quick (fun () ->
              let t = Exercise.bst_insert 5 Exercise.Leaf in
              Alcotest.(check bool) "not found 3" false (Exercise.bst_mem 3 t));
          Alcotest.test_case "mem on empty is false" `Quick (fun () ->
              Alcotest.(check bool) "false" false (Exercise.bst_mem 1 Exercise.Leaf));
          Alcotest.test_case "insert multiple elements" `Quick (fun () ->
              let t = List.fold_left (fun acc x -> Exercise.bst_insert x acc)
                        Exercise.Leaf [5;3;7;1;4;6;8] in
              List.iter (fun x ->
                Alcotest.(check bool) (string_of_int x ^ " found") true
                  (Exercise.bst_mem x t))
                [1;3;4;5;6;7;8]) ] );
      ( "Assignment 4: bst_to_sorted_list",
        [ Alcotest.test_case "in-order traversal" `Quick (fun () ->
              let t = List.fold_left (fun acc x -> Exercise.bst_insert x acc)
                        Exercise.Leaf [5;3;7;1;4;6;8] in
              Alcotest.(check (list int)) "sorted" [1;3;4;5;6;7;8]
                (Exercise.bst_to_sorted_list t));
          Alcotest.test_case "empty tree" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" []
                (Exercise.bst_to_sorted_list Exercise.Leaf));
          Alcotest.test_case "single element" `Quick (fun () ->
              let t = Exercise.bst_insert 42 Exercise.Leaf in
              Alcotest.(check (list int)) "one" [42]
                (Exercise.bst_to_sorted_list t)) ] );
      ( "Assignment 5: anagram_groups",
        [ Alcotest.test_case "groups anagrams" `Quick (fun () ->
              let words = ["eat";"tea";"tan";"ate";"nat";"bat"] in
              let m = Exercise.anagram_groups words in
              let result = string_map_to_sorted m in
              Alcotest.(check (list (pair string (list string)))) "groups"
                [ ("abt", ["bat"]);
                  ("aet", ["ate";"eat";"tea"]);
                  ("ant", ["nat";"tan"]) ]
                result);
          Alcotest.test_case "empty list" `Quick (fun () ->
              let m = Exercise.anagram_groups [] in
              Alcotest.(check (list (pair string (list string)))) "empty"
                [] (string_map_to_sorted m));
          Alcotest.test_case "no anagrams" `Quick (fun () ->
              let m = Exercise.anagram_groups ["abc";"def"] in
              let result = string_map_to_sorted m in
              Alcotest.(check (list (pair string (list string)))) "no groups"
                [("abc",["abc"]);("def",["def"])] result) ] ) ]
