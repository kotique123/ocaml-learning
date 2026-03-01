let person_eq =
  Alcotest.testable
    (fun ppf (p : Exercise.person) -> Format.fprintf ppf "{name=%s; age=%d; email=%s}" p.name p.age p.email)
    (fun (a : Exercise.person) b -> a.name = b.name && a.age = b.age && a.email = b.email)

let () =
  Alcotest.run "Exercise 09 — Variants and Records"
    [ ( "Assignment 1: opposite"
      , [ Alcotest.test_case "opposite North" `Quick (fun () ->
              Alcotest.(check bool) "opposite North = South" true
                (Exercise.opposite Exercise.North = Exercise.South))
        ; Alcotest.test_case "opposite South" `Quick (fun () ->
              Alcotest.(check bool) "opposite South = North" true
                (Exercise.opposite Exercise.South = Exercise.North))
        ; Alcotest.test_case "opposite East" `Quick (fun () ->
              Alcotest.(check bool) "opposite East = West" true
                (Exercise.opposite Exercise.East = Exercise.West))
        ; Alcotest.test_case "opposite West" `Quick (fun () ->
              Alcotest.(check bool) "opposite West = East" true
                (Exercise.opposite Exercise.West = Exercise.East))
        ] )
    ; ( "Assignment 2: is_horizontal"
      , [ Alcotest.test_case "North is not horizontal" `Quick (fun () ->
              Alcotest.(check bool) "is_horizontal North = false" false
                (Exercise.is_horizontal Exercise.North))
        ; Alcotest.test_case "East is horizontal" `Quick (fun () ->
              Alcotest.(check bool) "is_horizontal East = true" true
                (Exercise.is_horizontal Exercise.East))
        ; Alcotest.test_case "West is horizontal" `Quick (fun () ->
              Alcotest.(check bool) "is_horizontal West = true" true
                (Exercise.is_horizontal Exercise.West))
        ] )
    ; ( "Assignment 3: area"
      , [ Alcotest.test_case "circle area" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "area (Circle 1.0) = pi"
                Float.pi
                (Exercise.area (Exercise.Circle 1.0)))
        ; Alcotest.test_case "rectangle area" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "area (Rectangle 3.0 4.0) = 12.0"
                12.0
                (Exercise.area (Exercise.Rectangle (3.0, 4.0))))
        ; Alcotest.test_case "triangle area (3-4-5)" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "area (Triangle 3 4 5) = 6.0"
                6.0
                (Exercise.area (Exercise.Triangle (3.0, 4.0, 5.0))))
        ] )
    ; ( "Assignment 4: perimeter"
      , [ Alcotest.test_case "circle perimeter" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "perimeter (Circle 1.0) = 2*pi"
                (2.0 *. Float.pi)
                (Exercise.perimeter (Exercise.Circle 1.0)))
        ; Alcotest.test_case "rectangle perimeter" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "perimeter (Rectangle 3.0 4.0) = 14.0"
                14.0
                (Exercise.perimeter (Exercise.Rectangle (3.0, 4.0))))
        ; Alcotest.test_case "triangle perimeter" `Quick (fun () ->
              Alcotest.(check (float 1e-6))
                "perimeter (Triangle 3 4 5) = 12.0"
                12.0
                (Exercise.perimeter (Exercise.Triangle (3.0, 4.0, 5.0))))
        ] )
    ; ( "Assignment 5: make_person"
      , [ Alcotest.test_case "creates person with correct fields" `Quick (fun () ->
              let p = Exercise.make_person "Alice" 30 "alice@example.com" in
              Alcotest.(check string) "name" "Alice" p.name;
              Alcotest.(check int) "age" 30 p.age;
              Alcotest.(check string) "email" "alice@example.com" p.email)
        ; Alcotest.test_case "creates person with age 0" `Quick (fun () ->
              let p = Exercise.make_person "Baby" 0 "baby@example.com" in
              Alcotest.(check int) "age 0" 0 p.age)
        ; Alcotest.test_case "creates different persons independently" `Quick (fun () ->
              let p1 = Exercise.make_person "Alice" 30 "a@example.com" in
              let p2 = Exercise.make_person "Bob" 25 "b@example.com" in
              Alcotest.(check bool) "different names" true (p1.name <> p2.name))
        ] )
    ; ( "Assignment 6: is_adult"
      , [ Alcotest.test_case "age 17 is not adult" `Quick (fun () ->
              Alcotest.(check bool) "is_adult {age=17}" false
                (Exercise.is_adult (Exercise.make_person "Teen" 17 "teen@example.com")))
        ; Alcotest.test_case "age 18 is adult" `Quick (fun () ->
              Alcotest.(check bool) "is_adult {age=18}" true
                (Exercise.is_adult (Exercise.make_person "Adult" 18 "adult@example.com")))
        ; Alcotest.test_case "age 65 is adult" `Quick (fun () ->
              Alcotest.(check bool) "is_adult {age=65}" true
                (Exercise.is_adult (Exercise.make_person "Senior" 65 "senior@example.com")))
        ] )
    ; ( "Assignment 7: birthday"
      , [ Alcotest.test_case "increments age by 1" `Quick (fun () ->
              let p = Exercise.make_person "Alice" 30 "alice@example.com" in
              Alcotest.(check int) "age after birthday" 31 (Exercise.birthday p).age)
        ; Alcotest.test_case "preserves other fields" `Quick (fun () ->
              let p = Exercise.make_person "Bob" 25 "bob@example.com" in
              let p' = Exercise.birthday p in
              Alcotest.(check string) "name unchanged" "Bob" p'.name;
              Alcotest.(check string) "email unchanged" "bob@example.com" p'.email)
        ; Alcotest.test_case "does not mutate original" `Quick (fun () ->
              let p = Exercise.make_person "Carol" 20 "carol@example.com" in
              let _ = Exercise.birthday p in
              Alcotest.(check int) "original age unchanged" 20 p.age)
        ; Alcotest.test_case "birthday twice" `Quick (fun () ->
              let p = Exercise.make_person "Dave" 10 "dave@example.com" in
              Alcotest.(check person_eq)
                "age=12 after two birthdays"
                (Exercise.make_person "Dave" 12 "dave@example.com")
                (Exercise.birthday (Exercise.birthday p)))
        ] )
    ]
