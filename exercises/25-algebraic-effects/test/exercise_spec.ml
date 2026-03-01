let () =
  Alcotest.run "Exercise 25 — Algebraic Effects" [
    ( "Assignment 1: run_with_log",
      [ Alcotest.test_case "no logs" `Quick (fun () ->
            let open Exercise in
            let (result, logs) = run_with_log (fun () -> 42) in
            Alcotest.(check int) "result" 42 result;
            Alcotest.(check (list string)) "no logs" [] logs);
        Alcotest.test_case "single log" `Quick (fun () ->
            let open Exercise in
            let (result, logs) =
              run_with_log (fun () ->
                Effect.perform (Log "hello");
                1)
            in
            Alcotest.(check int) "result" 1 result;
            Alcotest.(check (list string)) "one log" [ "hello" ] logs);
        Alcotest.test_case "multiple logs in order" `Quick (fun () ->
            let open Exercise in
            let (result, logs) =
              run_with_log (fun () ->
                Effect.perform (Log "a");
                Effect.perform (Log "b");
                Effect.perform (Log "c");
                99)
            in
            Alcotest.(check int) "result" 99 result;
            Alcotest.(check (list string)) "three logs in order" [ "a"; "b"; "c" ] logs) ] );
    ( "Assignment 2: run_state",
      [ Alcotest.test_case "get returns initial state" `Quick (fun () ->
            let open Exercise in
            let (result, _) = run_state 10 (fun () -> Effect.perform Get) in
            Alcotest.(check int) "initial state returned" 10 result);
        Alcotest.test_case "put updates state" `Quick (fun () ->
            let open Exercise in
            let (_, final) =
              run_state 0 (fun () -> Effect.perform (Put 42))
            in
            Alcotest.(check int) "final state" 42 final);
        Alcotest.test_case "get after put" `Quick (fun () ->
            let open Exercise in
            let (result, final) =
              run_state 0 (fun () ->
                Effect.perform (Put 5);
                Effect.perform Get)
            in
            Alcotest.(check int) "result after put" 5 result;
            Alcotest.(check int) "final state" 5 final);
        Alcotest.test_case "stateful computation" `Quick (fun () ->
            let open Exercise in
            let (result, final) =
              run_state 0 (fun () ->
                let x = Effect.perform Get in
                Effect.perform (Put (x + 1));
                let y = Effect.perform Get in
                Effect.perform (Put (y + 10));
                Effect.perform Get)
            in
            Alcotest.(check int) "result" 11 result;
            Alcotest.(check int) "final state" 11 final) ] );
    ( "Assignment 3: run_with_abort",
      [ Alcotest.test_case "no abort returns result" `Quick (fun () ->
            let open Exercise in
            let result = run_with_abort (fun () -> 42) 0 in
            Alcotest.(check int) "result" 42 result);
        Alcotest.test_case "abort returns default" `Quick (fun () ->
            let open Exercise in
            let result =
              run_with_abort (fun () -> (Effect.perform Abort : int)) 0
            in
            Alcotest.(check int) "default" 0 result);
        Alcotest.test_case "abort skips remaining computation" `Quick (fun () ->
            let open Exercise in
            let side_effect = ref false in
            let result =
              run_with_abort
                (fun () ->
                  let _ = (Effect.perform Abort : int) in
                  side_effect := true;
                  99)
                (-1)
            in
            Alcotest.(check int) "default returned" (-1) result;
            Alcotest.(check bool) "remaining skipped" false !side_effect) ] );
  ]
