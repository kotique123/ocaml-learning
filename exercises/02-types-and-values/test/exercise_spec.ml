let () =
  Alcotest.run "Exercise 02 — Types and Values"
    [ ( "Assignment 1: int_to_string"
      , [ Alcotest.test_case "zero" `Quick (fun () ->
              Alcotest.(check string) "0" "0" (Exercise.int_to_string 0))
        ; Alcotest.test_case "positive" `Quick (fun () ->
              Alcotest.(check string) "42" "42" (Exercise.int_to_string 42))
        ; Alcotest.test_case "negative" `Quick (fun () ->
              Alcotest.(check string) "-7" "-7" (Exercise.int_to_string (-7)))
        ] )
    ; ( "Assignment 2: float_to_int"
      , [ Alcotest.test_case "truncates down" `Quick (fun () ->
              Alcotest.(check int) "3.9 -> 3" 3 (Exercise.float_to_int 3.9))
        ; Alcotest.test_case "truncates negative" `Quick (fun () ->
              Alcotest.(check int) "-2.7 -> -2" (-2) (Exercise.float_to_int (-2.7)))
        ; Alcotest.test_case "exact float" `Quick (fun () ->
              Alcotest.(check int) "5.0 -> 5" 5 (Exercise.float_to_int 5.0))
        ] )
    ; ( "Assignment 3: char_to_code"
      , [ Alcotest.test_case "code of 'A'" `Quick (fun () ->
              Alcotest.(check int) "A=65" 65 (Exercise.char_to_code 'A'))
        ; Alcotest.test_case "code of 'a'" `Quick (fun () ->
              Alcotest.(check int) "a=97" 97 (Exercise.char_to_code 'a'))
        ; Alcotest.test_case "code of '0'" `Quick (fun () ->
              Alcotest.(check int) "0=48" 48 (Exercise.char_to_code '0'))
        ] )
    ; ( "Assignment 4: code_to_char"
      , [ Alcotest.test_case "65 -> 'A'" `Quick (fun () ->
              Alcotest.(check char) "65=A" 'A' (Exercise.code_to_char 65))
        ; Alcotest.test_case "97 -> 'a'" `Quick (fun () ->
              Alcotest.(check char) "97=a" 'a' (Exercise.code_to_char 97))
        ; Alcotest.test_case "48 -> '0'" `Quick (fun () ->
              Alcotest.(check char) "48=0" '0' (Exercise.code_to_char 48))
        ] )
    ; ( "Assignment 5: is_digit"
      , [ Alcotest.test_case "'5' is digit" `Quick (fun () ->
              Alcotest.(check bool) "5 is digit" true (Exercise.is_digit '5'))
        ; Alcotest.test_case "'0' is digit" `Quick (fun () ->
              Alcotest.(check bool) "0 is digit" true (Exercise.is_digit '0'))
        ; Alcotest.test_case "'9' is digit" `Quick (fun () ->
              Alcotest.(check bool) "9 is digit" true (Exercise.is_digit '9'))
        ; Alcotest.test_case "'a' is not digit" `Quick (fun () ->
              Alcotest.(check bool) "a not digit" false (Exercise.is_digit 'a'))
        ; Alcotest.test_case "' ' is not digit" `Quick (fun () ->
              Alcotest.(check bool) "space not digit" false (Exercise.is_digit ' '))
        ] )
    ; ( "Assignment 6: celsius_to_fahrenheit"
      , [ Alcotest.test_case "0C = 32F" `Quick (fun () ->
              let result = Exercise.celsius_to_fahrenheit 0.0 in
              Alcotest.(check bool) "0C=32F" true (Float.abs (result -. 32.0) < 1e-9))
        ; Alcotest.test_case "100C = 212F" `Quick (fun () ->
              let result = Exercise.celsius_to_fahrenheit 100.0 in
              Alcotest.(check bool) "100C=212F" true (Float.abs (result -. 212.0) < 1e-9))
        ; Alcotest.test_case "-40C = -40F" `Quick (fun () ->
              let result = Exercise.celsius_to_fahrenheit (-40.0) in
              Alcotest.(check bool) "-40C=-40F" true (Float.abs (result -. (-40.0)) < 1e-9))
        ] )
    ]
