let string_map_int =
  Alcotest.testable
    (fun ppf m ->
      Exercise.StringMap.iter (fun k v -> Format.fprintf ppf "%s->%d " k v) m)
    (Exercise.StringMap.equal Int.equal)

let int_set =
  Alcotest.testable
    (fun ppf s -> Exercise.IntSet.iter (fun v -> Format.fprintf ppf "%d " v) s)
    Exercise.IntSet.equal

let int_map_string =
  Alcotest.testable
    (fun ppf m ->
      Exercise.IntMap.iter (fun k v -> Format.fprintf ppf "%d->%s " k v) m)
    (Exercise.IntMap.equal String.equal)

let make_smap bindings =
  List.fold_left
    (fun m (k, v) -> Exercise.StringMap.add k v m)
    Exercise.StringMap.empty bindings

let make_iset lst =
  List.fold_left
    (fun s x -> Exercise.IntSet.add x s)
    Exercise.IntSet.empty lst

let make_imap bindings =
  List.fold_left
    (fun m (k, v) -> Exercise.IntMap.add k v m)
    Exercise.IntMap.empty bindings

let () =
  Alcotest.run "Exercise 12 — Map and Set"
    [ ( "Assignment 1: word_count"
      , [ Alcotest.test_case "basic frequency counts" `Quick (fun () ->
            let expected = make_smap [ ("hello", 2); ("world", 1) ] in
            Alcotest.(check string_map_int)
              "counts" expected
              (Exercise.word_count [ "hello"; "world"; "hello" ]))
        ; Alcotest.test_case "empty list gives empty map" `Quick (fun () ->
            Alcotest.(check string_map_int)
              "empty" Exercise.StringMap.empty
              (Exercise.word_count []))
        ; Alcotest.test_case "single word" `Quick (fun () ->
            let expected = make_smap [ ("ocaml", 1) ] in
            Alcotest.(check string_map_int)
              "single" expected
              (Exercise.word_count [ "ocaml" ]))
        ] )
    ; ( "Assignment 2: most_frequent"
      , [ Alcotest.test_case "finds highest count" `Quick (fun () ->
            let m = make_smap [ ("a", 3); ("b", 1); ("c", 5) ] in
            Alcotest.(check (option (pair string int)))
              "max" (Some ("c", 5))
              (Exercise.most_frequent m))
        ; Alcotest.test_case "empty map returns None" `Quick (fun () ->
            Alcotest.(check (option (pair string int)))
              "none" None
              (Exercise.most_frequent Exercise.StringMap.empty))
        ] )
    ; ( "Assignment 3: unique_ints"
      , [ Alcotest.test_case "deduplicates integers" `Quick (fun () ->
            let expected = make_iset [ 1; 2; 3 ] in
            Alcotest.(check int_set)
              "unique" expected
              (Exercise.unique_ints [ 1; 2; 3; 2; 1 ]))
        ; Alcotest.test_case "empty list gives empty set" `Quick (fun () ->
            Alcotest.(check int_set)
              "empty" Exercise.IntSet.empty
              (Exercise.unique_ints []))
        ] )
    ; ( "Assignment 4: intersection_count"
      , [ Alcotest.test_case "overlapping sets" `Quick (fun () ->
            let s1 = make_iset [ 1; 2; 3; 4 ] in
            let s2 = make_iset [ 3; 4; 5; 6 ] in
            Alcotest.(check int) "count" 2
              (Exercise.intersection_count s1 s2))
        ; Alcotest.test_case "disjoint sets" `Quick (fun () ->
            let s1 = make_iset [ 1; 2 ] in
            let s2 = make_iset [ 3; 4 ] in
            Alcotest.(check int) "zero" 0
              (Exercise.intersection_count s1 s2))
        ; Alcotest.test_case "identical sets" `Quick (fun () ->
            let s = make_iset [ 1; 2; 3 ] in
            Alcotest.(check int) "three" 3
              (Exercise.intersection_count s s))
        ] )
    ; ( "Assignment 5: invert_map"
      , [ Alcotest.test_case "swaps keys and values" `Quick (fun () ->
            let m = make_smap [ ("one", 1); ("two", 2) ] in
            let expected = make_imap [ (1, "one"); (2, "two") ] in
            Alcotest.(check int_map_string)
              "inverted" expected
              (Exercise.invert_map m))
        ; Alcotest.test_case "empty map stays empty" `Quick (fun () ->
            Alcotest.(check int_map_string)
              "empty" Exercise.IntMap.empty
              (Exercise.invert_map Exercise.StringMap.empty))
        ] )
    ]
