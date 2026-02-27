let () =
  Alcotest.run "Exercise 05 — Conditionals"
    [ ( "Assignment 1: abs_val"
      , [ Alcotest.test_case "positive unchanged" `Quick (fun () ->
              Alcotest.(check int) "abs 5 = 5" 5 (Exercise.abs_val 5))
        ; Alcotest.test_case "negative becomes positive" `Quick (fun () ->
              Alcotest.(check int) "abs -3 = 3" 3 (Exercise.abs_val (-3)))
        ; Alcotest.test_case "zero unchanged" `Quick (fun () ->
              Alcotest.(check int) "abs 0 = 0" 0 (Exercise.abs_val 0))
        ] )
    ; ( "Assignment 2: clamp"
      , [ Alcotest.test_case "within range" `Quick (fun () ->
              Alcotest.(check int) "clamp 0 10 5 = 5" 5 (Exercise.clamp 0 10 5))
        ; Alcotest.test_case "below lo" `Quick (fun () ->
              Alcotest.(check int) "clamp 0 10 -1 = 0" 0 (Exercise.clamp 0 10 (-1)))
        ; Alcotest.test_case "above hi" `Quick (fun () ->
              Alcotest.(check int) "clamp 0 10 15 = 10" 10 (Exercise.clamp 0 10 15))
        ; Alcotest.test_case "at lo boundary" `Quick (fun () ->
              Alcotest.(check int) "clamp 0 10 0 = 0" 0 (Exercise.clamp 0 10 0))
        ; Alcotest.test_case "at hi boundary" `Quick (fun () ->
              Alcotest.(check int) "clamp 0 10 10 = 10" 10 (Exercise.clamp 0 10 10))
        ] )
    ; ( "Assignment 3: fizzbuzz"
      , [ Alcotest.test_case "fizzbuzz 15" `Quick (fun () ->
              Alcotest.(check string) "15=FizzBuzz" "FizzBuzz" (Exercise.fizzbuzz 15))
        ; Alcotest.test_case "fizz 9" `Quick (fun () ->
              Alcotest.(check string) "9=Fizz" "Fizz" (Exercise.fizzbuzz 9))
        ; Alcotest.test_case "buzz 10" `Quick (fun () ->
              Alcotest.(check string) "10=Buzz" "Buzz" (Exercise.fizzbuzz 10))
        ; Alcotest.test_case "plain 7" `Quick (fun () ->
              Alcotest.(check string) "7=7" "7" (Exercise.fizzbuzz 7))
        ; Alcotest.test_case "fizzbuzz 30" `Quick (fun () ->
              Alcotest.(check string) "30=FizzBuzz" "FizzBuzz" (Exercise.fizzbuzz 30))
        ] )
    ; ( "Assignment 4: grade"
      , [ Alcotest.test_case "A at 95" `Quick (fun () ->
              Alcotest.(check string) "95=A" "A" (Exercise.grade 95))
        ; Alcotest.test_case "B at 85" `Quick (fun () ->
              Alcotest.(check string) "85=B" "B" (Exercise.grade 85))
        ; Alcotest.test_case "C at 75" `Quick (fun () ->
              Alcotest.(check string) "75=C" "C" (Exercise.grade 75))
        ; Alcotest.test_case "D at 65" `Quick (fun () ->
              Alcotest.(check string) "65=D" "D" (Exercise.grade 65))
        ; Alcotest.test_case "F at 55" `Quick (fun () ->
              Alcotest.(check string) "55=F" "F" (Exercise.grade 55))
        ; Alcotest.test_case "A at exactly 90" `Quick (fun () ->
              Alcotest.(check string) "90=A" "A" (Exercise.grade 90))
        ] )
    ; ( "Assignment 5: leap_year"
      , [ Alcotest.test_case "2000 is leap (div 400)" `Quick (fun () ->
              Alcotest.(check bool) "2000 leap" true (Exercise.leap_year 2000))
        ; Alcotest.test_case "1900 not leap (div 100 not 400)" `Quick (fun () ->
              Alcotest.(check bool) "1900 not leap" false (Exercise.leap_year 1900))
        ; Alcotest.test_case "2024 is leap (div 4 not 100)" `Quick (fun () ->
              Alcotest.(check bool) "2024 leap" true (Exercise.leap_year 2024))
        ; Alcotest.test_case "2023 not leap" `Quick (fun () ->
              Alcotest.(check bool) "2023 not leap" false (Exercise.leap_year 2023))
        ] )
    ]
