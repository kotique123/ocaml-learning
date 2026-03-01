let () =
  Alcotest.run "Exercise 23 — PPX and Deriving" [
    ( "Assignment 1: color_to_hex",
      [ Alcotest.test_case "Red" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check string) "red hex" "#FF0000" (color_to_hex Red));
        Alcotest.test_case "Green" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check string) "green hex" "#00FF00" (color_to_hex Green));
        Alcotest.test_case "Blue" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check string) "blue hex" "#0000FF" (color_to_hex Blue)) ] );
    ( "Assignment 2: color show and eq",
      [ Alcotest.test_case "show_color produces non-empty string" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "non-empty" true (String.length (show_color Red) > 0));
        Alcotest.test_case "show_color distinguishes constructors" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "Red <> Green string" true
              (show_color Red <> show_color Green));
        Alcotest.test_case "equal_color same constructor" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "Red = Red" true (equal_color Red Red));
        Alcotest.test_case "equal_color different constructors" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "Red <> Blue" false (equal_color Red Blue));
        Alcotest.test_case "compare_color Red < Blue" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "Red < Blue" true (compare_color Red Blue < 0));
        Alcotest.test_case "compare_color equal" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "Green = Green" 0 (compare_color Green Green)) ] );
    ( "Assignment 3: distance",
      [ Alcotest.test_case "distance to self is 0" `Quick (fun () ->
            let open Exercise in
            let p = { x = 1.0; y = 2.0 } in
            Alcotest.(check (float 1e-9)) "zero distance" 0.0 (distance p p));
        Alcotest.test_case "3-4-5 right triangle" `Quick (fun () ->
            let open Exercise in
            let p1 = { x = 0.0; y = 0.0 } in
            let p2 = { x = 3.0; y = 4.0 } in
            Alcotest.(check (float 1e-9)) "hypotenuse 5" 5.0 (distance p1 p2));
        Alcotest.test_case "distance is symmetric" `Quick (fun () ->
            let open Exercise in
            let p1 = { x = 1.0; y = 2.0 } in
            let p2 = { x = 4.0; y = 6.0 } in
            Alcotest.(check (float 1e-9)) "symmetric" (distance p1 p2) (distance p2 p1)) ] );
    ( "Assignment 4: tree_depth",
      [ Alcotest.test_case "Leaf has depth 0" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "leaf" 0 (tree_depth Leaf));
        Alcotest.test_case "single node depth 1" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "node" 1 (tree_depth (Node (Leaf, 1, Leaf))));
        Alcotest.test_case "left-heavy depth 2" `Quick (fun () ->
            let open Exercise in
            let t = Node (Node (Leaf, 1, Leaf), 2, Leaf) in
            Alcotest.(check int) "depth 2" 2 (tree_depth t));
        Alcotest.test_case "balanced depth 2" `Quick (fun () ->
            let open Exercise in
            let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)) in
            Alcotest.(check int) "balanced depth 2" 2 (tree_depth t)) ] );
    ( "Assignment 5: tree_insert",
      [ Alcotest.test_case "insert into empty tree" `Quick (fun () ->
            let open Exercise in
            let t = tree_insert 5 Leaf in
            Alcotest.(check int) "depth 1" 1 (tree_depth t));
        Alcotest.test_case "insert smaller goes left" `Quick (fun () ->
            let open Exercise in
            let t = tree_insert 3 (Node (Leaf, 5, Leaf)) in
            Alcotest.(check bool) "correct structure" true
              (equal_tree ( = ) t
                 (Node (Node (Leaf, 3, Leaf), 5, Leaf))));
        Alcotest.test_case "insert larger goes right" `Quick (fun () ->
            let open Exercise in
            let t = tree_insert 7 (Node (Leaf, 5, Leaf)) in
            Alcotest.(check bool) "correct structure" true
              (equal_tree ( = ) t
                 (Node (Leaf, 5, Node (Leaf, 7, Leaf)))));
        Alcotest.test_case "duplicate not inserted" `Quick (fun () ->
            let open Exercise in
            let t0 = Node (Leaf, 5, Leaf) in
            let t1 = tree_insert 5 t0 in
            Alcotest.(check int) "depth unchanged" (tree_depth t0) (tree_depth t1)) ] );
  ]
