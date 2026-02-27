open Exercise

let () =
  let open Alcotest in
  run "Domains and Concurrency" [
    ( "Assignment 1: parallel_map",
      [ test_case "empty list" `Quick (fun () ->
            check (list int) "empty" [] (parallel_map (fun x -> x) []));
        test_case "double each element" `Quick (fun () ->
            check (list int) "doubled" [ 2; 4; 6 ]
              (parallel_map (fun x -> x * 2) [ 1; 2; 3 ]));
        test_case "preserves order" `Quick (fun () ->
            check (list int) "squares" [ 1; 4; 9; 16; 25 ]
              (parallel_map (fun x -> x * x) [ 1; 2; 3; 4; 5 ]));
        test_case "string map" `Quick (fun () ->
            check (list string) "upper" [ "A"; "B"; "C" ]
              (parallel_map String.uppercase_ascii [ "a"; "b"; "c" ])) ] );
    ( "Assignment 2: parallel_sum",
      [ test_case "empty list sums to 0" `Quick (fun () ->
            check int "empty" 0 (parallel_sum []));
        test_case "single element" `Quick (fun () ->
            check int "single" 42 (parallel_sum [ 42 ]));
        test_case "sum 1 to 5" `Quick (fun () ->
            check int "sum 15" 15 (parallel_sum [ 1; 2; 3; 4; 5 ]));
        test_case "sum with negatives" `Quick (fun () ->
            check int "net zero" 0 (parallel_sum [ 1; -1; 2; -2; 3; -3 ])) ] );
    ( "Assignment 3: thread_safe_counter",
      [ test_case "starts at zero" `Quick (fun () ->
            let (_, get) = thread_safe_counter () in
            check int "initial" 0 (get ()));
        test_case "increments correctly" `Quick (fun () ->
            let (inc, get) = thread_safe_counter () in
            inc ();
            inc ();
            inc ();
            check int "after 3" 3 (get ()));
        test_case "concurrent increments" `Quick (fun () ->
            let (inc, get) = thread_safe_counter () in
            let d1 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            let d2 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            Domain.join d1;
            Domain.join d2;
            check int "2000 increments" 2000 (get ())) ] );
    ( "Assignment 4: atomic_counter",
      [ test_case "starts at zero" `Quick (fun () ->
            let (_, get) = atomic_counter () in
            check int "initial" 0 (get ()));
        test_case "increments correctly" `Quick (fun () ->
            let (inc, get) = atomic_counter () in
            inc ();
            inc ();
            check int "after 2" 2 (get ()));
        test_case "concurrent increments" `Quick (fun () ->
            let (inc, get) = atomic_counter () in
            let d1 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            let d2 = Domain.spawn (fun () -> for _ = 1 to 1000 do inc () done) in
            Domain.join d1;
            Domain.join d2;
            check int "2000 increments" 2000 (get ())) ] );
  ]
