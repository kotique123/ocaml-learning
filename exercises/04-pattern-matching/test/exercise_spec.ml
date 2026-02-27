let () =
  Alcotest.run "Exercise 04 — Pattern Matching"
    [ ( "Assignment 1: describe_int"
      , [ Alcotest.test_case "zero" `Quick (fun () ->
              Alcotest.(check string) "zero" "zero" (Exercise.describe_int 0))
        ; Alcotest.test_case "positive" `Quick (fun () ->
              Alcotest.(check string) "positive" "positive" (Exercise.describe_int 5))
        ; Alcotest.test_case "negative" `Quick (fun () ->
              Alcotest.(check string) "negative" "negative" (Exercise.describe_int (-3)))
        ] )
    ; ( "Assignment 2: fst_of_triple"
      , [ Alcotest.test_case "int triple" `Quick (fun () ->
              Alcotest.(check int) "fst (1,2,3)=1" 1 (Exercise.fst_of_triple (1, 2, 3)))
        ; Alcotest.test_case "string triple" `Quick (fun () ->
              Alcotest.(check string) "fst (a,b,c)=a" "a"
                (Exercise.fst_of_triple ("a", "b", "c")))
        ; Alcotest.test_case "mixed triple" `Quick (fun () ->
              Alcotest.(check bool) "fst (true,0,'x')=true" true
                (Exercise.fst_of_triple (true, 0, 'x')))
        ] )
    ; ( "Assignment 3: classify_pair"
      , [ Alcotest.test_case "both zero" `Quick (fun () ->
              Alcotest.(check string) "(0,0)" "both zero" (Exercise.classify_pair (0, 0)))
        ; Alcotest.test_case "first zero" `Quick (fun () ->
              Alcotest.(check string) "(0,5)" "first zero" (Exercise.classify_pair (0, 5)))
        ; Alcotest.test_case "second zero" `Quick (fun () ->
              Alcotest.(check string) "(3,0)" "second zero" (Exercise.classify_pair (3, 0)))
        ; Alcotest.test_case "neither zero" `Quick (fun () ->
              Alcotest.(check string) "(1,2)" "neither zero" (Exercise.classify_pair (1, 2)))
        ] )
    ; ( "Assignment 4: area"
      , [ Alcotest.test_case "circle radius 1" `Quick (fun () ->
              let result = Exercise.area (Exercise.Circle 1.0) in
              Alcotest.(check bool) "circle area pi" true
                (Float.abs (result -. Float.pi) < 1e-9))
        ; Alcotest.test_case "rectangle 3x4" `Quick (fun () ->
              let result = Exercise.area (Exercise.Rectangle (3.0, 4.0)) in
              Alcotest.(check bool) "rect 3x4=12" true (Float.abs (result -. 12.0) < 1e-9))
        ; Alcotest.test_case "3-4-5 triangle" `Quick (fun () ->
              let result = Exercise.area (Exercise.Triangle (3.0, 4.0, 5.0)) in
              Alcotest.(check bool) "triangle 3-4-5=6" true (Float.abs (result -. 6.0) < 1e-9))
        ] )
    ; ( "Assignment 5: is_right_triangle"
      , [ Alcotest.test_case "3-4-5 is right" `Quick (fun () ->
              Alcotest.(check bool) "3-4-5 right" true
                (Exercise.is_right_triangle 3.0 4.0 5.0))
        ; Alcotest.test_case "5-12-13 is right" `Quick (fun () ->
              Alcotest.(check bool) "5-12-13 right" true
                (Exercise.is_right_triangle 5.0 12.0 13.0))
        ; Alcotest.test_case "1-2-3 is not right" `Quick (fun () ->
              Alcotest.(check bool) "1-2-3 not right" false
                (Exercise.is_right_triangle 1.0 2.0 3.0))
        ] )
    ]
