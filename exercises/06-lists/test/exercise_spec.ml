let () =
  Alcotest.run "Exercise 06 — lists"
    [ ( "Assignment 1: sum"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check int) "sum []" 0 (Exercise.sum []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check int) "sum [5]" 5 (Exercise.sum [ 5 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check int) "sum [1;2;3;4]" 10 (Exercise.sum [ 1; 2; 3; 4 ]))
        ] )
    ; ( "Assignment 2: product"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check int) "product []" 1 (Exercise.product []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check int) "product [7]" 7 (Exercise.product [ 7 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check int) "product [2;3;4]" 24 (Exercise.product [ 2; 3; 4 ]))
        ] )
    ; ( "Assignment 3: evens"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int)) "evens []" [] (Exercise.evens []))
        ; Alcotest.test_case "single even" `Quick (fun () ->
              Alcotest.(check (list int)) "evens [4]" [ 4 ] (Exercise.evens [ 4 ]))
        ; Alcotest.test_case "mixed list" `Quick (fun () ->
              Alcotest.(check (list int))
                "evens [1;2;3;4;5;6]"
                [ 2; 4; 6 ]
                (Exercise.evens [ 1; 2; 3; 4; 5; 6 ]))
        ] )
    ; ( "Assignment 4: double_all"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int)) "double_all []" [] (Exercise.double_all []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (list int)) "double_all [3]" [ 6 ] (Exercise.double_all [ 3 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check (list int))
                "double_all [1;2;3]"
                [ 2; 4; 6 ]
                (Exercise.double_all [ 1; 2; 3 ]))
        ] )
    ; ( "Assignment 5: my_last"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (option int)) "my_last []" None (Exercise.my_last []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (option int))
                "my_last [42]"
                (Some 42)
                (Exercise.my_last [ 42 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check (option int))
                "my_last [1;2;3]"
                (Some 3)
                (Exercise.my_last [ 1; 2; 3 ]))
        ] )
    ; ( "Assignment 6: zip"
      , [ Alcotest.test_case "empty lists" `Quick (fun () ->
              Alcotest.(check (list (pair int int))) "zip [] []" [] (Exercise.zip [] []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (list (pair int int)))
                "zip [1] [4]"
                [ (1, 4) ]
                (Exercise.zip [ 1 ] [ 4 ]))
        ; Alcotest.test_case "equal length lists" `Quick (fun () ->
              Alcotest.(check (list (pair int int)))
                "zip [1;2;3] [4;5;6]"
                [ (1, 4); (2, 5); (3, 6) ]
                (Exercise.zip [ 1; 2; 3 ] [ 4; 5; 6 ]))
        ; Alcotest.test_case "unequal length stops at shorter" `Quick (fun () ->
              Alcotest.(check (list (pair int int)))
                "zip [1;2] [4;5;6]"
                [ (1, 4); (2, 5) ]
                (Exercise.zip [ 1; 2 ] [ 4; 5; 6 ]))
        ] )
    ; ( "Assignment 7: flatten"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int)) "flatten []" [] (Exercise.flatten []))
        ; Alcotest.test_case "single sublist" `Quick (fun () ->
              Alcotest.(check (list int))
                "flatten [[1;2;3]]"
                [ 1; 2; 3 ]
                (Exercise.flatten [ [ 1; 2; 3 ] ]))
        ; Alcotest.test_case "multiple sublists" `Quick (fun () ->
              Alcotest.(check (list int))
                "flatten [[1;2];[3];[4;5]]"
                [ 1; 2; 3; 4; 5 ]
                (Exercise.flatten [ [ 1; 2 ]; [ 3 ]; [ 4; 5 ] ]))
        ] )
    ]
