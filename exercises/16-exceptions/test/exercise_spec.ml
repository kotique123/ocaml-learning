let () =
  Alcotest.run "Exercise 16 — Exceptions"
    [ ( "Assignment 1: safe_div",
        [ Alcotest.test_case "divides evenly" `Quick (fun () ->
              Alcotest.(check int) "10/2=5" 5 (Exercise.safe_div 10 2));
          Alcotest.test_case "divides with remainder" `Quick (fun () ->
              Alcotest.(check int) "7/3=2" 2 (Exercise.safe_div 7 3));
          Alcotest.test_case "raises on zero" `Quick (fun () ->
              Alcotest.check_raises "division by zero"
                (Exercise.Division_by_zero_custom "division by zero")
                (fun () -> ignore (Exercise.safe_div 10 0)));
          Alcotest.test_case "zero divided by non-zero" `Quick (fun () ->
              Alcotest.(check int) "0/5=0" 0 (Exercise.safe_div 0 5)) ] );
      ( "Assignment 2: safe_nth",
        [ Alcotest.test_case "first element" `Quick (fun () ->
              Alcotest.(check int) "lst[0]=1" 1 (Exercise.safe_nth [1;2;3] 0));
          Alcotest.test_case "last element" `Quick (fun () ->
              Alcotest.(check int) "lst[2]=3" 3 (Exercise.safe_nth [1;2;3] 2));
          Alcotest.test_case "raises on negative index" `Quick (fun () ->
              Alcotest.check_raises "negative index"
                (Exercise.Out_of_range { index = -1; length = 3 })
                (fun () -> ignore (Exercise.safe_nth [1;2;3] (-1))));
          Alcotest.test_case "raises on index >= length" `Quick (fun () ->
              Alcotest.check_raises "index out of bounds"
                (Exercise.Out_of_range { index = 3; length = 3 })
                (fun () -> ignore (Exercise.safe_nth [1;2;3] 3)));
          Alcotest.test_case "raises on empty list" `Quick (fun () ->
              Alcotest.check_raises "empty list"
                (Exercise.Out_of_range { index = 0; length = 0 })
                (fun () -> ignore (Exercise.safe_nth [] 0))) ] );
      ( "Assignment 3: try_div",
        [ Alcotest.test_case "ok on normal division" `Quick (fun () ->
              Alcotest.(check (result int string)) "ok 5"
                (Ok 5) (Exercise.try_div 10 2));
          Alcotest.test_case "error on divide by zero" `Quick (fun () ->
              Alcotest.(check (result int string)) "error msg"
                (Error "division by zero") (Exercise.try_div 10 0));
          Alcotest.test_case "ok when dividend is zero" `Quick (fun () ->
              Alcotest.(check (result int string)) "ok 0"
                (Ok 0) (Exercise.try_div 0 5)) ] );
      ( "Assignment 4: with_default",
        [ Alcotest.test_case "returns function result on success" `Quick (fun () ->
              Alcotest.(check int) "42" 42
                (Exercise.with_default 0 (fun () -> 42)));
          Alcotest.test_case "returns default on exception" `Quick (fun () ->
              Alcotest.(check int) "default 99" 99
                (Exercise.with_default 99 (fun () -> failwith "boom")));
          Alcotest.test_case "returns default on Not_found" `Quick (fun () ->
              Alcotest.(check string) "default" "fallback"
                (Exercise.with_default "fallback" (fun () -> raise Not_found))) ] );
      ( "Assignment 5: validate_age",
        [ Alcotest.test_case "valid age 0" `Quick (fun () ->
              Alcotest.(check int) "0" 0 (Exercise.validate_age 0));
          Alcotest.test_case "valid age 25" `Quick (fun () ->
              Alcotest.(check int) "25" 25 (Exercise.validate_age 25));
          Alcotest.test_case "valid age 150" `Quick (fun () ->
              Alcotest.(check int) "150" 150 (Exercise.validate_age 150));
          Alcotest.test_case "raises on negative" `Quick (fun () ->
              Alcotest.check_raises "negative age"
                (Invalid_argument "age must be 0..150")
                (fun () -> ignore (Exercise.validate_age (-1))));
          Alcotest.test_case "raises on > 150" `Quick (fun () ->
              Alcotest.check_raises "too large"
                (Invalid_argument "age must be 0..150")
                (fun () -> ignore (Exercise.validate_age 151))) ] ) ]
