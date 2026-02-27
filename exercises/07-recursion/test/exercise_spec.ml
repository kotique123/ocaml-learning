let () =
  Alcotest.run "Exercise 07 — recursion"
    [ ( "Assignment 1: factorial"
      , [ Alcotest.test_case "factorial 0" `Quick (fun () ->
              Alcotest.(check int) "0! = 1" 1 (Exercise.factorial 0))
        ; Alcotest.test_case "factorial 1" `Quick (fun () ->
              Alcotest.(check int) "1! = 1" 1 (Exercise.factorial 1))
        ; Alcotest.test_case "factorial 5" `Quick (fun () ->
              Alcotest.(check int) "5! = 120" 120 (Exercise.factorial 5))
        ; Alcotest.test_case "factorial 10" `Quick (fun () ->
              Alcotest.(check int) "10! = 3628800" 3628800 (Exercise.factorial 10))
        ] )
    ; ( "Assignment 2: fibonacci"
      , [ Alcotest.test_case "fib 0" `Quick (fun () ->
              Alcotest.(check int) "fib 0 = 0" 0 (Exercise.fibonacci 0))
        ; Alcotest.test_case "fib 1" `Quick (fun () ->
              Alcotest.(check int) "fib 1 = 1" 1 (Exercise.fibonacci 1))
        ; Alcotest.test_case "fib 6" `Quick (fun () ->
              Alcotest.(check int) "fib 6 = 8" 8 (Exercise.fibonacci 6))
        ; Alcotest.test_case "fib 10" `Quick (fun () ->
              Alcotest.(check int) "fib 10 = 55" 55 (Exercise.fibonacci 10))
        ] )
    ; ( "Assignment 3: my_length"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check int) "my_length []" 0 (Exercise.my_length []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check int) "my_length [42]" 1 (Exercise.my_length [ 42 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check int)
                "my_length [1;2;3;4;5]"
                5
                (Exercise.my_length [ 1; 2; 3; 4; 5 ]))
        ] )
    ; ( "Assignment 4: my_reverse"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int)) "my_reverse []" [] (Exercise.my_reverse []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (list int))
                "my_reverse [1]"
                [ 1 ]
                (Exercise.my_reverse [ 1 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check (list int))
                "my_reverse [1;2;3]"
                [ 3; 2; 1 ]
                (Exercise.my_reverse [ 1; 2; 3 ]))
        ] )
    ; ( "Assignment 5: my_map"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int))
                "my_map (+1) []"
                []
                (Exercise.my_map (( + ) 1) []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (list int))
                "my_map (*2) [3]"
                [ 6 ]
                (Exercise.my_map (( * ) 2) [ 3 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check (list int))
                "my_map (*2) [1;2;3]"
                [ 2; 4; 6 ]
                (Exercise.my_map (( * ) 2) [ 1; 2; 3 ]))
        ] )
    ; ( "Assignment 6: count_down"
      , [ Alcotest.test_case "count_down 0" `Quick (fun () ->
              Alcotest.(check (list int)) "count_down 0" [ 0 ] (Exercise.count_down 0))
        ; Alcotest.test_case "count_down 1" `Quick (fun () ->
              Alcotest.(check (list int))
                "count_down 1"
                [ 1; 0 ]
                (Exercise.count_down 1))
        ; Alcotest.test_case "count_down 4" `Quick (fun () ->
              Alcotest.(check (list int))
                "count_down 4"
                [ 4; 3; 2; 1; 0 ]
                (Exercise.count_down 4))
        ] )
    ; ( "Assignment 7: power"
      , [ Alcotest.test_case "power x 0" `Quick (fun () ->
              Alcotest.(check int) "2^0 = 1" 1 (Exercise.power 2 0))
        ; Alcotest.test_case "power x 1" `Quick (fun () ->
              Alcotest.(check int) "5^1 = 5" 5 (Exercise.power 5 1))
        ; Alcotest.test_case "power 2 10" `Quick (fun () ->
              Alcotest.(check int) "2^10 = 1024" 1024 (Exercise.power 2 10))
        ; Alcotest.test_case "power 3 4" `Quick (fun () ->
              Alcotest.(check int) "3^4 = 81" 81 (Exercise.power 3 4))
        ] )
    ]
