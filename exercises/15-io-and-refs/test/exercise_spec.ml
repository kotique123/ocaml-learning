let () =
  Alcotest.run "Exercise 15 — io-and-refs"
    [ ( "Assignment 1: make_counter"
      , [ Alcotest.test_case "starts at 0" `Quick (fun () ->
            let (_, get) = Exercise.make_counter () in
            Alcotest.(check int) "0" 0 (get ()))
        ; Alcotest.test_case "increments correctly" `Quick (fun () ->
            let (incr, get) = Exercise.make_counter () in
            incr (); incr ();
            Alcotest.(check int) "2" 2 (get ()))
        ; Alcotest.test_case "independent counters do not share state" `Quick (fun () ->
            let (incr1, get1) = Exercise.make_counter () in
            let (_, get2) = Exercise.make_counter () in
            incr1 ();
            Alcotest.(check int) "c1=1" 1 (get1 ());
            Alcotest.(check int) "c2=0" 0 (get2 ()))
        ] )
    ; ( "Assignment 2: memoize"
      , [ Alcotest.test_case "returns correct result" `Quick (fun () ->
            let memo_sq = Exercise.memoize (fun x -> x * x) in
            Alcotest.(check int) "25" 25 (memo_sq 5))
        ; Alcotest.test_case "underlying function called only once per argument" `Quick
            (fun () ->
              let count = ref 0 in
              let f x = incr count; x * 2 in
              let mf = Exercise.memoize f in
              let _ = mf 7 in
              let _ = mf 7 in
              let _ = mf 7 in
              Alcotest.(check int) "called-once" 1 !count)
        ; Alcotest.test_case "different arguments each call the function" `Quick (fun () ->
            let count = ref 0 in
            let f x = incr count; x + 1 in
            let mf = Exercise.memoize f in
            let _ = mf 1 in
            let _ = mf 2 in
            Alcotest.(check int) "called-twice" 2 !count)
        ] )
    ; ( "Assignment 3: read_lines / write_lines"
      , [ Alcotest.test_case "round-trip write then read" `Quick (fun () ->
            let fname = Filename.temp_file "ex15" ".txt" in
            let lines = [ "first line"; "second line"; "third line" ] in
            Exercise.write_lines fname lines;
            let result = Exercise.read_lines fname in
            Sys.remove fname;
            Alcotest.(check (list string)) "lines" lines result)
        ; Alcotest.test_case "missing file returns empty list" `Quick (fun () ->
            Alcotest.(check (list string)) "empty" []
              (Exercise.read_lines "/nonexistent/__exercise15_missing__.txt"))
        ] )
    ; ( "Assignment 4: running_average"
      , [ Alcotest.test_case "single value average equals itself" `Quick (fun () ->
            let (add, avg) = Exercise.running_average () in
            add 10.0;
            Alcotest.(check (float 1e-6)) "10.0" 10.0 (avg ()))
        ; Alcotest.test_case "average of 10, 20, 30 is 20" `Quick (fun () ->
            let (add, avg) = Exercise.running_average () in
            add 10.0; add 20.0; add 30.0;
            Alcotest.(check (float 1e-6)) "20.0" 20.0 (avg ()))
        ; Alcotest.test_case "independent instances do not share state" `Quick (fun () ->
            let (add1, avg1) = Exercise.running_average () in
            let (add2, avg2) = Exercise.running_average () in
            add1 100.0;
            add2 0.0;
            Alcotest.(check (float 1e-6)) "avg1=100" 100.0 (avg1 ());
            Alcotest.(check (float 1e-6)) "avg2=0" 0.0 (avg2 ()))
        ] )
    ]
