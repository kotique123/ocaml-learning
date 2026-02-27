open Exercise

let () =
  let open Alcotest in
  run "Algebraic Effects" [
    ( "Assignment 1: run_with_log",
      [ test_case "no logs" `Quick (fun () ->
            let (result, logs) = run_with_log (fun () -> 42) in
            check int "result" 42 result;
            check (list string) "no logs" [] logs);
        test_case "single log" `Quick (fun () ->
            let (result, logs) =
              run_with_log (fun () ->
                Effect.perform (Log "hello");
                1)
            in
            check int "result" 1 result;
            check (list string) "one log" [ "hello" ] logs);
        test_case "multiple logs in order" `Quick (fun () ->
            let (result, logs) =
              run_with_log (fun () ->
                Effect.perform (Log "a");
                Effect.perform (Log "b");
                Effect.perform (Log "c");
                99)
            in
            check int "result" 99 result;
            check (list string) "three logs in order" [ "a"; "b"; "c" ] logs) ] );
    ( "Assignment 2: run_state",
      [ test_case "get returns initial state" `Quick (fun () ->
            let (result, _) = run_state 10 (fun () -> Effect.perform Get) in
            check int "initial state returned" 10 result);
        test_case "put updates state" `Quick (fun () ->
            let (_, final) =
              run_state 0 (fun () -> Effect.perform (Put 42))
            in
            check int "final state" 42 final);
        test_case "get after put" `Quick (fun () ->
            let (result, final) =
              run_state 0 (fun () ->
                Effect.perform (Put 5);
                Effect.perform Get)
            in
            check int "result after put" 5 result;
            check int "final state" 5 final);
        test_case "stateful computation" `Quick (fun () ->
            let (result, final) =
              run_state 0 (fun () ->
                let x = Effect.perform Get in
                Effect.perform (Put (x + 1));
                let y = Effect.perform Get in
                Effect.perform (Put (y + 10));
                Effect.perform Get)
            in
            check int "result" 11 result;
            check int "final state" 11 final) ] );
    ( "Assignment 3: run_with_abort",
      [ test_case "no abort returns result" `Quick (fun () ->
            let result = run_with_abort (fun () -> 42) 0 in
            check int "result" 42 result);
        test_case "abort returns default" `Quick (fun () ->
            let result =
              run_with_abort (fun () -> (Effect.perform Abort : int)) 0
            in
            check int "default" 0 result);
        test_case "abort skips remaining computation" `Quick (fun () ->
            let side_effect = ref false in
            let result =
              run_with_abort
                (fun () ->
                  let _ = (Effect.perform Abort : int) in
                  side_effect := true;
                  99)
                (-1)
            in
            check int "default returned" (-1) result;
            check bool "remaining skipped" false !side_effect) ] );
  ]
