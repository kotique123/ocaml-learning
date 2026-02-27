open Exercise

let () =
  let open Alcotest in
  run "PPX and Deriving" [
    ( "Assignment 1: color_to_hex",
      [ test_case "Red" `Quick (fun () ->
            check string "red hex" "#FF0000" (color_to_hex Red));
        test_case "Green" `Quick (fun () ->
            check string "green hex" "#00FF00" (color_to_hex Green));
        test_case "Blue" `Quick (fun () ->
            check string "blue hex" "#0000FF" (color_to_hex Blue)) ] );
    ( "Assignment 2: color show and eq",
      [ test_case "show_color produces non-empty string" `Quick (fun () ->
            check bool "non-empty" true (String.length (show_color Red) > 0));
        test_case "show_color distinguishes constructors" `Quick (fun () ->
            check bool "Red <> Green string" true
              (show_color Red <> show_color Green));
        test_case "equal_color same constructor" `Quick (fun () ->
            check bool "Red = Red" true (equal_color Red Red));
        test_case "equal_color different constructors" `Quick (fun () ->
            check bool "Red <> Blue" false (equal_color Red Blue));
        test_case "compare_color Red < Blue" `Quick (fun () ->
            check bool "Red < Blue" true (compare_color Red Blue < 0));
        test_case "compare_color equal" `Quick (fun () ->
            check int "Green = Green" 0 (compare_color Green Green)) ] );
    ( "Assignment 3: distance",
      [ test_case "distance to self is 0" `Quick (fun () ->
            let p = { x = 1.0; y = 2.0 } in
            check (float 1e-9) "zero distance" 0.0 (distance p p));
        test_case "3-4-5 right triangle" `Quick (fun () ->
            let p1 = { x = 0.0; y = 0.0 } in
            let p2 = { x = 3.0; y = 4.0 } in
            check (float 1e-9) "hypotenuse 5" 5.0 (distance p1 p2));
        test_case "distance is symmetric" `Quick (fun () ->
            let p1 = { x = 1.0; y = 2.0 } in
            let p2 = { x = 4.0; y = 6.0 } in
            check (float 1e-9) "symmetric" (distance p1 p2) (distance p2 p1)) ] );
    ( "Assignment 4: tree_depth",
      [ test_case "Leaf has depth 0" `Quick (fun () ->
            check int "leaf" 0 (tree_depth Leaf));
        test_case "single node depth 1" `Quick (fun () ->
            check int "node" 1 (tree_depth (Node (Leaf, 1, Leaf))));
        test_case "left-heavy depth 2" `Quick (fun () ->
            let t = Node (Node (Leaf, 1, Leaf), 2, Leaf) in
            check int "depth 2" 2 (tree_depth t));
        test_case "balanced depth 2" `Quick (fun () ->
            let t = Node (Node (Leaf, 1, Leaf), 2, Node (Leaf, 3, Leaf)) in
            check int "balanced depth 2" 2 (tree_depth t)) ] );
    ( "Assignment 5: tree_insert",
      [ test_case "insert into empty tree" `Quick (fun () ->
            let t = tree_insert 5 Leaf in
            check int "depth 1" 1 (tree_depth t));
        test_case "insert smaller goes left" `Quick (fun () ->
            let t = tree_insert 3 (Node (Leaf, 5, Leaf)) in
            check bool "correct structure" true
              (equal_tree ( = ) t
                 (Node (Node (Leaf, 3, Leaf), 5, Leaf))));
        test_case "insert larger goes right" `Quick (fun () ->
            let t = tree_insert 7 (Node (Leaf, 5, Leaf)) in
            check bool "correct structure" true
              (equal_tree ( = ) t
                 (Node (Leaf, 5, Node (Leaf, 7, Leaf)))));
        test_case "duplicate not inserted" `Quick (fun () ->
            let t0 = Node (Leaf, 5, Leaf) in
            let t1 = tree_insert 5 t0 in
            check int "depth unchanged" (tree_depth t0) (tree_depth t1)) ] );
  ]
