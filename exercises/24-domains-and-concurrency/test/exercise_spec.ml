let () =
  Alcotest.run "Exercise 24 — Domains and Concurrency" [
    ( "Assignment 1: parallel_map",
      [ Alcotest.test_case "empty list" `Quick (fun () ->
            Alcotest.(check (list int)) "empty" [] (Exercise.parallel_map (fun x -> x) []));
        Alcotest.test_case "double each element" `Quick (fun () ->
            Alcotest.(check (list int)) "doubled" [ 2; 4; 6 ]
              (Exercise.parallel_map (fun x -> x * 2) [ 1; 2; 3 ]));
        Alcotest.test_case "preserves order" `Quick (fun () ->
            Alcotest.(check (list int)) "squares" [ 1; 4; 9; 16; 25 ]
              (Exercise.parallel_map (fun x -> x * x) [ 1; 2; 3; 4; 5 ]));
        Alcotest.test_case "string map" `Quick (fun () ->
            Alcotest.(check (list string)) "upper" [ "A"; "B"; "C" ]
              (Exercise.parallel_map String.uppercase_ascii [ "a"; "b"; "c" ])) ] );
    ( "Assignment 2: parallel_sum",
      [ Alcotest.test_case "empty list sums to 0" `Quick (fun () ->
            Alcotest.(check int) "empty" 0 (Exercise.parallel_sum []));
        Alcotest.test_case "single element" `Quick (fun () ->
            Alcotest.(check int) "single" 42 (Exercise.parallel_sum [ 42 ]));
        Alcotest.test_case "sum 1 to 5" `Quick (fun () ->
            Alcotest.(check int) "sum 15" 15 (Exercise.parallel_sum [ 1; 2; 3; 4; 5 ]));
        Alcotest.test_case "sum with negatives" `Quick (fun () ->
            Alcotest.(check int) "net zero" 0 (Exercise.parallel_sum [ 1; -1; 2; -2; 3; -3 ])) ] );
    ( "Assignment 3: thread_safe_counter",
      [ Alcotest.test_case "starts at zero" `Quick (fun () ->
            let (_, get) = Exercise.thread_safe_counter () in
            Alcotest.(check int) "initial" 0 (get ()));
        Alcotest.test_case "increments correctly" `Quick (fun () ->
            let (inc, get) = Exercise.thread_safe_counter () in
            inc ();
            inc ();
            inc ();
            Alcotest.(check int) "after 3" 3 (get ()));
        Alcotest.test_case "concurrent increments" `Quick (fun () ->
            let (inc, get) = Exercise.thread_safe_counter () in
            let d1 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            let d2 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            Domain.join d1;
            Domain.join d2;
            Alcotest.(check int) "2000 increments" 2000 (get ())) ] );
    ( "Assignment 4: atomic_counter",
      [ Alcotest.test_case "starts at zero" `Quick (fun () ->
            let (_, get) = Exercise.atomic_counter () in
            Alcotest.(check int) "initial" 0 (get ()));
        Alcotest.test_case "increments correctly" `Quick (fun () ->
            let (inc, get) = Exercise.atomic_counter () in
            inc ();
            inc ();
            Alcotest.(check int) "after 2" 2 (get ()));
        Alcotest.test_case "concurrent increments" `Quick (fun () ->
            let (inc, get) = Exercise.atomic_counter () in
            let d1 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            let d2 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            Domain.join d1;
            Domain.join d2;
            Alcotest.(check int) "2000 increments" 2000 (get ())) ] );
  ]
