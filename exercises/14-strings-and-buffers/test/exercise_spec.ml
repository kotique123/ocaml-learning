let () =
  Alcotest.run "Exercise 14 — Strings and Buffers"
    [ ( "Assignment 1: palindrome"
      , [ Alcotest.test_case "\"racecar\" is a palindrome" `Quick (fun () ->
            Alcotest.(check bool) "true" true (Exercise.palindrome "racecar"))
        ; Alcotest.test_case "\"Madam\" is a palindrome (case-insensitive)" `Quick (fun () ->
            Alcotest.(check bool) "true" true (Exercise.palindrome "Madam"))
        ; Alcotest.test_case "\"hello\" is not a palindrome" `Quick (fun () ->
            Alcotest.(check bool) "false" false (Exercise.palindrome "hello"))
        ; Alcotest.test_case "single character is a palindrome" `Quick (fun () ->
            Alcotest.(check bool) "true" true (Exercise.palindrome "a"))
        ] )
    ; ( "Assignment 2: word_wrap"
      , [ Alcotest.test_case "wrap at width 10" `Quick (fun () ->
            Alcotest.(check (list string)) "lines"
              [ "the quick"; "brown fox" ]
              (Exercise.word_wrap "the quick brown fox" 10))
        ; Alcotest.test_case "short text needs no wrap" `Quick (fun () ->
            Alcotest.(check (list string)) "single-line"
              [ "hello" ]
              (Exercise.word_wrap "hello" 20))
        ; Alcotest.test_case "each word on its own line when width is tight" `Quick (fun () ->
            Alcotest.(check (list string)) "each-word"
              [ "hi"; "ho" ]
              (Exercise.word_wrap "hi ho" 4))
        ] )
    ; ( "Assignment 3: count_vowels"
      , [ Alcotest.test_case "\"hello\" has 2 vowels" `Quick (fun () ->
            Alcotest.(check int) "2" 2 (Exercise.count_vowels "hello"))
        ; Alcotest.test_case "\"AEIOU\" has 5 vowels (uppercase)" `Quick (fun () ->
            Alcotest.(check int) "5" 5 (Exercise.count_vowels "AEIOU"))
        ; Alcotest.test_case "\"rhythm\" has 0 vowels" `Quick (fun () ->
            Alcotest.(check int) "0" 0 (Exercise.count_vowels "rhythm"))
        ] )
    ; ( "Assignment 4: title_case"
      , [ Alcotest.test_case "\"hello world\" -> \"Hello World\"" `Quick (fun () ->
            Alcotest.(check string) "titled" "Hello World"
              (Exercise.title_case "hello world"))
        ; Alcotest.test_case "\"the quick brown fox\"" `Quick (fun () ->
            Alcotest.(check string) "titled" "The Quick Brown Fox"
              (Exercise.title_case "the quick brown fox"))
        ; Alcotest.test_case "single word" `Quick (fun () ->
            Alcotest.(check string) "word" "Ocaml"
              (Exercise.title_case "ocaml"))
        ] )
    ; ( "Assignment 5: repeat_string"
      , [ Alcotest.test_case "repeat \"a\" 3 times" `Quick (fun () ->
            Alcotest.(check string) "aaa" "aaa"
              (Exercise.repeat_string "a" 3))
        ; Alcotest.test_case "repeat 0 times gives empty string" `Quick (fun () ->
            Alcotest.(check string) "empty" ""
              (Exercise.repeat_string "ab" 0))
        ; Alcotest.test_case "repeat \"ha\" 3 times" `Quick (fun () ->
            Alcotest.(check string) "hahaha" "hahaha"
              (Exercise.repeat_string "ha" 3))
        ] )
    ; ( "Assignment 6: csv_row"
      , [ Alcotest.test_case "simple fields joined by commas" `Quick (fun () ->
            Alcotest.(check string) "csv" "a,b,c"
              (Exercise.csv_row [ "a"; "b"; "c" ]))
        ; Alcotest.test_case "field containing comma is quoted" `Quick (fun () ->
            Alcotest.(check string) "quoted" {|a,"b,c",d|}
              (Exercise.csv_row [ "a"; "b,c"; "d" ]))
        ; Alcotest.test_case "single field, no comma" `Quick (fun () ->
            Alcotest.(check string) "single" "hello"
              (Exercise.csv_row [ "hello" ]))
        ] )
    ]
