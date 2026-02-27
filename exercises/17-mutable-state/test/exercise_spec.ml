let pp_int_list ppf lst =
  Alcotest.(pp (list int)) ppf lst

let hashtbl_to_sorted_list tbl =
  Hashtbl.fold (fun k v acc -> (k, v) :: acc) tbl []
  |> List.sort compare

let () =
  Alcotest.run "Exercise 17 — Mutable State"
    [ ( "Assignment 1: swap",
        [ Alcotest.test_case "swaps two ints" `Quick (fun () ->
              let r1 = ref 1 and r2 = ref 2 in
              Exercise.swap r1 r2;
              Alcotest.(check int) "r1=2" 2 !r1;
              Alcotest.(check int) "r2=1" 1 !r2);
          Alcotest.test_case "swaps equal refs" `Quick (fun () ->
              let r1 = ref 5 and r2 = ref 5 in
              Exercise.swap r1 r2;
              Alcotest.(check int) "r1=5" 5 !r1;
              Alcotest.(check int) "r2=5" 5 !r2);
          Alcotest.test_case "swaps strings" `Quick (fun () ->
              let r1 = ref "hello" and r2 = ref "world" in
              Exercise.swap r1 r2;
              Alcotest.(check string) "r1=world" "world" !r1;
              Alcotest.(check string) "r2=hello" "hello" !r2) ] );
      ( "Assignment 2: array_fill_range",
        [ Alcotest.test_case "fills entire array" `Quick (fun () ->
              let arr = [|0;0;0;0;0|] in
              Exercise.array_fill_range arr 0 4 7;
              Alcotest.(check (array int)) "all 7s" [|7;7;7;7;7|] arr);
          Alcotest.test_case "fills partial range" `Quick (fun () ->
              let arr = [|1;2;3;4;5|] in
              Exercise.array_fill_range arr 1 3 9;
              Alcotest.(check (array int)) "middle filled" [|1;9;9;9;5|] arr);
          Alcotest.test_case "fills single element" `Quick (fun () ->
              let arr = [|10;20;30|] in
              Exercise.array_fill_range arr 1 1 99;
              Alcotest.(check (array int)) "one element" [|10;99;30|] arr) ] );
      ( "Assignment 3: histogram",
        [ Alcotest.test_case "counts frequencies" `Quick (fun () ->
              let tbl = Exercise.histogram [1;2;1;3;2;1] in
              let result = hashtbl_to_sorted_list tbl in
              Alcotest.(check (list (pair int int))) "frequencies"
                [(1,3);(2,2);(3,1)] result);
          Alcotest.test_case "empty list" `Quick (fun () ->
              let tbl = Exercise.histogram [] in
              Alcotest.(check int) "size 0" 0 (Hashtbl.length tbl));
          Alcotest.test_case "all same element" `Quick (fun () ->
              let tbl = Exercise.histogram [5;5;5] in
              let result = hashtbl_to_sorted_list tbl in
              Alcotest.(check (list (pair int int))) "one key" [(5,3)] result) ] );
      ( "Assignment 4: dedup_array",
        [ Alcotest.test_case "removes consecutive duplicates" `Quick (fun () ->
              Alcotest.(check (array int)) "deduped"
                [|1;2;3;2|]
                (Exercise.dedup_array [|1;1;2;3;3;3;2|]));
          Alcotest.test_case "no duplicates unchanged" `Quick (fun () ->
              Alcotest.(check (array int)) "unchanged"
                [|1;2;3|]
                (Exercise.dedup_array [|1;2;3|]));
          Alcotest.test_case "all same" `Quick (fun () ->
              Alcotest.(check (array int)) "one element"
                [|4|]
                (Exercise.dedup_array [|4;4;4;4|]));
          Alcotest.test_case "empty array" `Quick (fun () ->
              Alcotest.(check (array int)) "empty"
                [||]
                (Exercise.dedup_array [||]));
          Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (array int)) "single"
                [|7|]
                (Exercise.dedup_array [|7|])) ] );
      ( "Assignment 5: queue_rotate",
        [ Alcotest.test_case "rotate by 1" `Quick (fun () ->
              let q = Queue.of_seq (List.to_seq [1;2;3;4]) in
              Exercise.queue_rotate q 1;
              let result = Queue.fold (fun acc x -> acc @ [x]) [] q in
              Alcotest.(check (list int)) "rotated 1" [2;3;4;1] result);
          Alcotest.test_case "rotate by 2" `Quick (fun () ->
              let q = Queue.of_seq (List.to_seq [1;2;3;4]) in
              Exercise.queue_rotate q 2;
              let result = Queue.fold (fun acc x -> acc @ [x]) [] q in
              Alcotest.(check (list int)) "rotated 2" [3;4;1;2] result);
          Alcotest.test_case "rotate by 0" `Quick (fun () ->
              let q = Queue.of_seq (List.to_seq [1;2;3]) in
              Exercise.queue_rotate q 0;
              let result = Queue.fold (fun acc x -> acc @ [x]) [] q in
              Alcotest.(check (list int)) "unchanged" [1;2;3] result);
          Alcotest.test_case "rotate empty queue" `Quick (fun () ->
              let q : int Queue.t = Queue.create () in
              Exercise.queue_rotate q 3;
              Alcotest.(check int) "still empty" 0 (Queue.length q)) ] ) ]

let _ = pp_int_list
