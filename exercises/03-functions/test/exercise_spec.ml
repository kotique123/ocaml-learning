let () =
  Alcotest.run "Exercise 03 — Functions"
    [ ( "Assignment 1: apply"
      , [ Alcotest.test_case "apply succ" `Quick (fun () ->
              Alcotest.(check int) "succ 4 = 5" 5 (Exercise.apply succ 4))
        ; Alcotest.test_case "apply string_of_int" `Quick (fun () ->
              Alcotest.(check string) "string_of_int 7" "7" (Exercise.apply string_of_int 7))
        ; Alcotest.test_case "apply identity" `Quick (fun () ->
              Alcotest.(check int) "id 42 = 42" 42 (Exercise.apply (fun x -> x) 42))
        ] )
    ; ( "Assignment 2: compose"
      , [ Alcotest.test_case "compose succ double" `Quick (fun () ->
              Alcotest.(check int) "succ (double 3) = 7" 7
                (Exercise.compose succ (fun x -> x * 2) 3))
        ; Alcotest.test_case "compose string_of_int succ" `Quick (fun () ->
              Alcotest.(check string) "string (succ 9) = 10" "10"
                (Exercise.compose string_of_int succ 9))
        ] )
    ; ( "Assignment 3: flip"
      , [ Alcotest.test_case "flip sub" `Quick (fun () ->
              Alcotest.(check int) "flip (-) 3 10 = 7" 7
                (Exercise.flip ( - ) 3 10))
        ; Alcotest.test_case "flip const" `Quick (fun () ->
              Alcotest.(check int) "flip const 99 1 = 1" 1
                (Exercise.flip (fun a _b -> a) 99 1))
        ] )
    ; ( "Assignment 4: add (partial application)"
      , [ Alcotest.test_case "add 3 4 = 7" `Quick (fun () ->
              Alcotest.(check int) "3+4" 7 (Exercise.add 3 4))
        ; Alcotest.test_case "partial add5" `Quick (fun () ->
              let add5 = Exercise.add 5 in
              Alcotest.(check int) "add5 10 = 15" 15 (add5 10))
        ; Alcotest.test_case "partial add0" `Quick (fun () ->
              let add0 = Exercise.add 0 in
              Alcotest.(check int) "add0 42 = 42" 42 (add0 42))
        ] )
    ; ( "Assignment 5: pipeline"
      , [ Alcotest.test_case "empty pipeline" `Quick (fun () ->
              Alcotest.(check int) "pipeline 5 [] = 5" 5 (Exercise.pipeline 5 []))
        ; Alcotest.test_case "single step" `Quick (fun () ->
              Alcotest.(check int) "pipeline 3 [*2] = 6" 6
                (Exercise.pipeline 3 [ (fun x -> x * 2) ]))
        ; Alcotest.test_case "multiple steps" `Quick (fun () ->
              Alcotest.(check int) "pipeline 1 [+1;*3;+2] = 8" 8
                (Exercise.pipeline 1
                   [ (fun x -> x + 1); (fun x -> x * 3); (fun x -> x + 2) ]))
        ] )
    ; ( "Assignment 6: twice"
      , [ Alcotest.test_case "twice succ 0 = 2" `Quick (fun () ->
              Alcotest.(check int) "twice succ 0" 2 (Exercise.twice succ 0))
        ; Alcotest.test_case "twice double 3 = 12" `Quick (fun () ->
              Alcotest.(check int) "twice double 3" 12
                (Exercise.twice (fun x -> x * 2) 3))
        ; Alcotest.test_case "twice id = id" `Quick (fun () ->
              Alcotest.(check string) "twice id hello" "hello"
                (Exercise.twice (fun x -> x) "hello"))
        ] )
    ]
