let () =
  Alcotest.run "Exercise 11 — option-and-result"
    [ ( "Assignment 1: safe_div"
      , [ Alcotest.test_case "6 / 2 = Some 3" `Quick (fun () ->
            Alcotest.(check (option int)) "some" (Some 3) (Exercise.safe_div 6 2))
        ; Alcotest.test_case "6 / 0 = None" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None (Exercise.safe_div 6 0))
        ; Alcotest.test_case "0 / 5 = Some 0" `Quick (fun () ->
            Alcotest.(check (option int)) "zero" (Some 0) (Exercise.safe_div 0 5))
        ] )
    ; ( "Assignment 2: safe_sqrt"
      , [ Alcotest.test_case "sqrt 4.0 = Some 2.0" `Quick (fun () ->
            Alcotest.(check (option (float 1e-6))) "some" (Some 2.0)
              (Exercise.safe_sqrt 4.0))
        ; Alcotest.test_case "sqrt 0.0 = Some 0.0" `Quick (fun () ->
            Alcotest.(check (option (float 1e-6))) "zero" (Some 0.0)
              (Exercise.safe_sqrt 0.0))
        ; Alcotest.test_case "sqrt -1.0 = None" `Quick (fun () ->
            Alcotest.(check (option (float 1e-6))) "none" None
              (Exercise.safe_sqrt (-1.0)))
        ] )
    ; ( "Assignment 3: option_map"
      , [ Alcotest.test_case "map Some doubles value" `Quick (fun () ->
            Alcotest.(check (option int)) "double" (Some 4)
              (Exercise.option_map (fun x -> x * 2) (Some 2)))
        ; Alcotest.test_case "map None returns None" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None
              (Exercise.option_map (fun x -> x * 2) None))
        ] )
    ; ( "Assignment 4: option_bind"
      , [ Alcotest.test_case "bind Some -> Some" `Quick (fun () ->
            Alcotest.(check (option int)) "bind" (Some 5)
              (Exercise.option_bind (Some 10) (fun x -> Some (x / 2))))
        ; Alcotest.test_case "bind None -> None" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None
              (Exercise.option_bind None (fun x -> Some (x / 2))))
        ; Alcotest.test_case "bind Some -> None" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None
              (Exercise.option_bind (Some 0) (fun _ -> None)))
        ] )
    ; ( "Assignment 5: parse_int"
      , [ Alcotest.test_case "parse \"42\"" `Quick (fun () ->
            Alcotest.(check (result int string)) "ok" (Ok 42)
              (Exercise.parse_int "42"))
        ; Alcotest.test_case "parse \"-7\"" `Quick (fun () ->
            Alcotest.(check (result int string)) "ok" (Ok (-7))
              (Exercise.parse_int "-7"))
        ; Alcotest.test_case "parse \"abc\" gives Error" `Quick (fun () ->
            match Exercise.parse_int "abc" with
            | Error _ -> ()
            | Ok _ -> Alcotest.fail "expected Error for non-integer input")
        ] )
    ; ( "Assignment 6: result_map"
      , [ Alcotest.test_case "map Ok value" `Quick (fun () ->
            Alcotest.(check (result int string)) "doubled" (Ok 6)
              (Exercise.result_map (fun x -> x * 2) (Ok 3)))
        ; Alcotest.test_case "Error passes through unchanged" `Quick (fun () ->
            Alcotest.(check (result int string)) "error" (Error "oops")
              (Exercise.result_map (fun x -> x * 2) (Error "oops")))
        ] )
    ; ( "Assignment 7: chain_divs"
      , [ Alcotest.test_case "120 / 4 / 5 = Some 6" `Quick (fun () ->
            Alcotest.(check (option int)) "some" (Some 6)
              (Exercise.chain_divs 120 4 5))
        ; Alcotest.test_case "div by zero first divisor" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None
              (Exercise.chain_divs 10 0 5))
        ; Alcotest.test_case "div by zero second divisor" `Quick (fun () ->
            Alcotest.(check (option int)) "none" None
              (Exercise.chain_divs 10 5 0))
        ] )
    ]
