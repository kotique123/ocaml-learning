let () =
  Alcotest.run "Exercise 08 — Higher-Order Functions"
    [ ( "Assignment 1: my_fold_left"
      , [ Alcotest.test_case "sum empty" `Quick (fun () ->
              Alcotest.(check int)
                "fold_left (+) 0 []"
                0
                (Exercise.my_fold_left ( + ) 0 []))
        ; Alcotest.test_case "sum list" `Quick (fun () ->
              Alcotest.(check int)
                "fold_left (+) 0 [1;2;3;4]"
                10
                (Exercise.my_fold_left ( + ) 0 [ 1; 2; 3; 4 ]))
        ; Alcotest.test_case "product list" `Quick (fun () ->
              Alcotest.(check int)
                "fold_left (*) 1 [2;3;4]"
                24
                (Exercise.my_fold_left ( * ) 1 [ 2; 3; 4 ]))
        ] )
    ; ( "Assignment 2: compose"
      , [ Alcotest.test_case "compose two functions" `Quick (fun () ->
              Alcotest.(check int)
                "compose (+1) (*2) 3 = 7"
                7
                (Exercise.compose (( + ) 1) (( * ) 2) 3))
        ; Alcotest.test_case "compose identity" `Quick (fun () ->
              Alcotest.(check int)
                "compose id (+1) 4 = 5"
                5
                (Exercise.compose Fun.id (( + ) 1) 4))
        ; Alcotest.test_case "compose string functions" `Quick (fun () ->
              Alcotest.(check int)
                "compose String.length string_of_int 42"
                2
                (Exercise.compose String.length string_of_int 42))
        ] )
    ; ( "Assignment 3: apply_twice"
      , [ Alcotest.test_case "apply_twice (+3) 0" `Quick (fun () ->
              Alcotest.(check int) "0+3+3=6" 6 (Exercise.apply_twice (( + ) 3) 0))
        ; Alcotest.test_case "apply_twice (*2) 1" `Quick (fun () ->
              Alcotest.(check int) "1*2*2=4" 4 (Exercise.apply_twice (( * ) 2) 1))
        ; Alcotest.test_case "apply_twice List.rev" `Quick (fun () ->
              Alcotest.(check (list int))
                "rev rev [1;2;3] = [1;2;3]"
                [ 1; 2; 3 ]
                (Exercise.apply_twice List.rev [ 1; 2; 3 ]))
        ] )
    ; ( "Assignment 4: count_if"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check int)
                "count_if even []"
                0
                (Exercise.count_if (fun x -> x mod 2 = 0) []))
        ; Alcotest.test_case "none match" `Quick (fun () ->
              Alcotest.(check int)
                "count_if even [1;3;5]"
                0
                (Exercise.count_if (fun x -> x mod 2 = 0) [ 1; 3; 5 ]))
        ; Alcotest.test_case "some match" `Quick (fun () ->
              Alcotest.(check int)
                "count_if even [1;2;3;4]"
                2
                (Exercise.count_if (fun x -> x mod 2 = 0) [ 1; 2; 3; 4 ]))
        ] )
    ; ( "Assignment 5: flat_map"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list int))
                "flat_map (fun x -> [x;x]) []"
                []
                (Exercise.flat_map (fun x -> [ x; x ]) []))
        ; Alcotest.test_case "single element" `Quick (fun () ->
              Alcotest.(check (list int))
                "flat_map (fun x -> [x;x]) [3]"
                [ 3; 3 ]
                (Exercise.flat_map (fun x -> [ x; x ]) [ 3 ]))
        ; Alcotest.test_case "multiple elements" `Quick (fun () ->
              Alcotest.(check (list int))
                "flat_map (fun x -> [x;x+1]) [1;3]"
                [ 1; 2; 3; 4 ]
                (Exercise.flat_map (fun x -> [ x; x + 1 ]) [ 1; 3 ]))
        ] )
    ; ( "Assignment 6: partition_by"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (pair (list int) (list int)))
                "partition_by even []"
                ([], [])
                (Exercise.partition_by (fun x -> x mod 2 = 0) []))
        ; Alcotest.test_case "all match" `Quick (fun () ->
              Alcotest.(check (pair (list int) (list int)))
                "partition_by even [2;4;6]"
                ([ 2; 4; 6 ], [])
                (Exercise.partition_by (fun x -> x mod 2 = 0) [ 2; 4; 6 ]))
        ; Alcotest.test_case "mixed" `Quick (fun () ->
              Alcotest.(check (pair (list int) (list int)))
                "partition_by even [1;2;3;4]"
                ([ 2; 4 ], [ 1; 3 ])
                (Exercise.partition_by (fun x -> x mod 2 = 0) [ 1; 2; 3; 4 ]))
        ] )
    ; ( "Assignment 7: group_by"
      , [ Alcotest.test_case "empty list" `Quick (fun () ->
              Alcotest.(check (list (list int)))
                "group_by 2 []"
                []
                (Exercise.group_by 2 []))
        ; Alcotest.test_case "exact chunks" `Quick (fun () ->
              Alcotest.(check (list (list int)))
                "group_by 2 [1;2;3;4]"
                [ [ 1; 2 ]; [ 3; 4 ] ]
                (Exercise.group_by 2 [ 1; 2; 3; 4 ]))
        ; Alcotest.test_case "last chunk smaller" `Quick (fun () ->
              Alcotest.(check (list (list int)))
                "group_by 2 [1;2;3;4;5]"
                [ [ 1; 2 ]; [ 3; 4 ]; [ 5 ] ]
                (Exercise.group_by 2 [ 1; 2; 3; 4; 5 ]))
        ] )
    ]
