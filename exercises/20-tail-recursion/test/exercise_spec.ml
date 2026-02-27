let large_list n = List.init n (fun i -> i + 1)

let () =
  Alcotest.run "Exercise 20 — Tail Recursion"
    [ ( "Assignment 1: sum_naive",
        [ Alcotest.test_case "sum empty" `Quick (fun () ->
              Alcotest.(check int) "0" 0 (Exercise.sum_naive []));
          Alcotest.test_case "sum [1..5]" `Quick (fun () ->
              Alcotest.(check int) "15" 15 (Exercise.sum_naive [1;2;3;4;5]));
          Alcotest.test_case "sum [1]" `Quick (fun () ->
              Alcotest.(check int) "1" 1 (Exercise.sum_naive [1])) ] );
      ( "Assignment 2: sum_tr",
        [ Alcotest.test_case "sum empty" `Quick (fun () ->
              Alcotest.(check int) "0" 0 (Exercise.sum_tr []));
          Alcotest.test_case "sum [1..5]" `Quick (fun () ->
              Alcotest.(check int) "15" 15 (Exercise.sum_tr [1;2;3;4;5]));
          Alcotest.test_case "large list does not overflow" `Quick (fun () ->
              let n = 1_000_000 in
              let lst = large_list n in
              let expected = n * (n + 1) / 2 in
              Alcotest.(check int) "sum 1M" expected (Exercise.sum_tr lst)) ] );
      ( "Assignment 3: reverse_tr",
        [ Alcotest.test_case "reverse empty" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" [] (Exercise.reverse_tr []));
          Alcotest.test_case "reverse [1;2;3]" `Quick (fun () ->
              Alcotest.(check (list int)) "reversed" [3;2;1]
                (Exercise.reverse_tr [1;2;3]));
          Alcotest.test_case "reverse single" `Quick (fun () ->
              Alcotest.(check (list int)) "single" [42]
                (Exercise.reverse_tr [42]));
          Alcotest.test_case "large list does not overflow" `Quick (fun () ->
              let lst = large_list 1_000_000 in
              let rev = Exercise.reverse_tr lst in
              Alcotest.(check int) "head is 1M" 1_000_000 (List.hd rev)) ] );
      ( "Assignment 4: flatten_tr",
        [ Alcotest.test_case "flatten empty" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" [] (Exercise.flatten_tr []));
          Alcotest.test_case "flatten [[1;2];[3;4]]" `Quick (fun () ->
              Alcotest.(check (list int)) "flattened" [1;2;3;4]
                (Exercise.flatten_tr [[1;2];[3;4]]));
          Alcotest.test_case "flatten with empty sublists" `Quick (fun () ->
              Alcotest.(check (list int)) "with empties" [1;2;3]
                (Exercise.flatten_tr [[];[1;2];[];[3];[]]));
          Alcotest.test_case "large nested does not overflow" `Quick (fun () ->
              let lst = List.init 1000 (fun _ -> large_list 1000) in
              let result = Exercise.flatten_tr lst in
              Alcotest.(check int) "length 1M" 1_000_000 (List.length result)) ] );
      ( "Assignment 5: map_tr",
        [ Alcotest.test_case "map empty" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" []
                (Exercise.map_tr (fun x -> x * 2) []));
          Alcotest.test_case "map double" `Quick (fun () ->
              Alcotest.(check (list int)) "doubled" [2;4;6]
                (Exercise.map_tr (fun x -> x * 2) [1;2;3]));
          Alcotest.test_case "map to string" `Quick (fun () ->
              Alcotest.(check (list string)) "strings" ["1";"2";"3"]
                (Exercise.map_tr string_of_int [1;2;3]));
          Alcotest.test_case "large list does not overflow" `Quick (fun () ->
              let lst = large_list 1_000_000 in
              let result = Exercise.map_tr (fun x -> x + 1) lst in
              Alcotest.(check int) "head is 2" 2 (List.hd result)) ] );
      ( "Assignment 6: fibonacci_tr",
        [ Alcotest.test_case "fib 0 = 0" `Quick (fun () ->
              Alcotest.(check int) "fib(0)" 0 (Exercise.fibonacci_tr 0));
          Alcotest.test_case "fib 1 = 1" `Quick (fun () ->
              Alcotest.(check int) "fib(1)" 1 (Exercise.fibonacci_tr 1));
          Alcotest.test_case "fib 2 = 1" `Quick (fun () ->
              Alcotest.(check int) "fib(2)" 1 (Exercise.fibonacci_tr 2));
          Alcotest.test_case "fib 10 = 55" `Quick (fun () ->
              Alcotest.(check int) "fib(10)" 55 (Exercise.fibonacci_tr 10));
          Alcotest.test_case "fib 20 = 6765" `Quick (fun () ->
              Alcotest.(check int) "fib(20)" 6765 (Exercise.fibonacci_tr 20));
          Alcotest.test_case "large n does not overflow stack" `Quick (fun () ->
              let result = Exercise.fibonacci_tr 80 in
              Alcotest.(check bool) "fib(80) > 0" true (result > 0)) ] );
      ( "Assignment 7: range",
        [ Alcotest.test_case "range 0 5" `Quick (fun () ->
              Alcotest.(check (list int)) "0..4" [0;1;2;3;4]
                (Exercise.range 0 5));
          Alcotest.test_case "range 3 7" `Quick (fun () ->
              Alcotest.(check (list int)) "3..6" [3;4;5;6]
                (Exercise.range 3 7));
          Alcotest.test_case "range lo = hi is empty" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" []
                (Exercise.range 5 5));
          Alcotest.test_case "range lo > hi is empty" `Quick (fun () ->
              Alcotest.(check (list int)) "empty" []
                (Exercise.range 7 3));
          Alcotest.test_case "large range does not overflow" `Quick (fun () ->
              let result = Exercise.range 0 1_000_000 in
              Alcotest.(check int) "length 1M" 1_000_000 (List.length result)) ] ) ]
