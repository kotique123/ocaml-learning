let () =
  Alcotest.run "Exercise 01 — Hello OCaml"
    [ ( "Assignment 1: greet"
      , [ Alcotest.test_case "greets a name" `Quick (fun () ->
              Alcotest.(check string) "greet World" "Hello, World!" (Exercise.greet "World"))
        ; Alcotest.test_case "greets another name" `Quick (fun () ->
              Alcotest.(check string) "greet OCaml" "Hello, OCaml!" (Exercise.greet "OCaml"))
        ] )
    ; ( "Assignment 2: double"
      , [ Alcotest.test_case "double zero" `Quick (fun () ->
              Alcotest.(check int) "double 0" 0 (Exercise.double 0))
        ; Alcotest.test_case "double positive" `Quick (fun () ->
              Alcotest.(check int) "double 7" 14 (Exercise.double 7))
        ; Alcotest.test_case "double negative" `Quick (fun () ->
              Alcotest.(check int) "double -3" (-6) (Exercise.double (-3)))
        ] )
    ; ( "Assignment 3: circle_area"
      , [ Alcotest.test_case "area of radius 1 is pi" `Quick (fun () ->
              let result = Exercise.circle_area 1.0 in
              Alcotest.(check bool) "close to pi" true (Float.abs (result -. Float.pi) < 1e-9))
        ; Alcotest.test_case "area of radius 0 is 0" `Quick (fun () ->
              Alcotest.(check (float 0.)) "area 0" 0.0 (Exercise.circle_area 0.0))
        ] )
    ; ( "Assignment 4: bmi"
      , [ Alcotest.test_case "underweight" `Quick (fun () ->
              Alcotest.(check string) "bmi under" "Underweight" (Exercise.bmi 45.0 1.75))
        ; Alcotest.test_case "normal" `Quick (fun () ->
              Alcotest.(check string) "bmi normal" "Normal" (Exercise.bmi 70.0 1.75))
        ; Alcotest.test_case "overweight" `Quick (fun () ->
              Alcotest.(check string) "bmi over" "Overweight" (Exercise.bmi 100.0 1.75))
        ] )
    ]
