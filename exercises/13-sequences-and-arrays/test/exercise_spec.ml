let () =
  Alcotest.run "Exercise 13 — sequences-and-arrays"
    [ ( "Assignment 1: array_sum"
      , [ Alcotest.test_case "sum of [|1..5|]" `Quick (fun () ->
            Alcotest.(check int) "15" 15
              (Exercise.array_sum [| 1; 2; 3; 4; 5 |]))
        ; Alcotest.test_case "empty array sums to 0" `Quick (fun () ->
            Alcotest.(check int) "0" 0
              (Exercise.array_sum [||]))
        ; Alcotest.test_case "single element" `Quick (fun () ->
            Alcotest.(check int) "7" 7
              (Exercise.array_sum [| 7 |]))
        ] )
    ; ( "Assignment 2: array_rotate"
      , [ Alcotest.test_case "rotate left 2" `Quick (fun () ->
            Alcotest.(check (array int)) "rotated"
              [| 3; 4; 5; 1; 2 |]
              (Exercise.array_rotate [| 1; 2; 3; 4; 5 |] 2))
        ; Alcotest.test_case "rotate by 0 is identity" `Quick (fun () ->
            Alcotest.(check (array int)) "unchanged"
              [| 1; 2; 3 |]
              (Exercise.array_rotate [| 1; 2; 3 |] 0))
        ; Alcotest.test_case "rotate full length is identity" `Quick (fun () ->
            Alcotest.(check (array int)) "full-rotation"
              [| 1; 2; 3 |]
              (Exercise.array_rotate [| 1; 2; 3 |] 3))
        ] )
    ; ( "Assignment 3: running_total"
      , [ Alcotest.test_case "prefix sums of [|1;2;3;4|]" `Quick (fun () ->
            Alcotest.(check (array int)) "sums"
              [| 1; 3; 6; 10 |]
              (Exercise.running_total [| 1; 2; 3; 4 |]))
        ; Alcotest.test_case "single element unchanged" `Quick (fun () ->
            Alcotest.(check (array int)) "single"
              [| 5 |]
              (Exercise.running_total [| 5 |]))
        ] )
    ; ( "Assignment 4: naturals"
      , [ Alcotest.test_case "first 5 naturals are 0..4" `Quick (fun () ->
            Alcotest.(check (list int)) "0..4" [ 0; 1; 2; 3; 4 ]
              (Exercise.naturals () |> Seq.take 5 |> List.of_seq))
        ; Alcotest.test_case "first element is 0" `Quick (fun () ->
            Alcotest.(check (list int)) "starts-at-0" [ 0 ]
              (Exercise.naturals () |> Seq.take 1 |> List.of_seq))
        ] )
    ; ( "Assignment 5: seq_take"
      , [ Alcotest.test_case "take 3 from a 5-element sequence" `Quick (fun () ->
            let seq = List.to_seq [ 10; 20; 30; 40; 50 ] in
            Alcotest.(check (list int)) "first-3" [ 10; 20; 30 ]
              (Exercise.seq_take 3 seq))
        ; Alcotest.test_case "take 0 gives empty list" `Quick (fun () ->
            let seq = List.to_seq [ 1; 2; 3 ] in
            Alcotest.(check (list int)) "empty" []
              (Exercise.seq_take 0 seq))
        ] )
    ; ( "Assignment 6: seq_squares"
      , [ Alcotest.test_case "first 5 squares" `Quick (fun () ->
            Alcotest.(check (list int)) "squares" [ 1; 4; 9; 16; 25 ]
              (Exercise.seq_squares 5))
        ; Alcotest.test_case "first 1 square" `Quick (fun () ->
            Alcotest.(check (list int)) "one" [ 1 ]
              (Exercise.seq_squares 1))
        ; Alcotest.test_case "0 squares gives empty list" `Quick (fun () ->
            Alcotest.(check (list int)) "empty" []
              (Exercise.seq_squares 0))
        ] )
    ]
