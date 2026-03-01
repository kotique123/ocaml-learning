let () =
  Alcotest.run "Exercise 21 — Polymorphism" [
    ( "Assignment 1: push and top",
      [ Alcotest.test_case "push onto empty stack" `Quick (fun () ->
            let open Exercise in
            let s = push 1 Empty_stack in
            Alcotest.(check int) "top is 1" 1 (top s));
        Alcotest.test_case "push multiple elements" `Quick (fun () ->
            let open Exercise in
            let s = push 3 (push 2 (push 1 Empty_stack)) in
            Alcotest.(check int) "top is last pushed" 3 (top s));
        Alcotest.test_case "push string" `Quick (fun () ->
            let open Exercise in
            let s = push "hello" Empty_stack in
            Alcotest.(check string) "top string" "hello" (top s)) ] );
    ( "Assignment 2: pop",
      [ Alcotest.test_case "pop single element" `Quick (fun () ->
            let open Exercise in
            let s = push 42 Empty_stack in
            let (v, _) = pop s in
            Alcotest.(check int) "popped value" 42 v);
        Alcotest.test_case "pop reveals top of two-element stack" `Quick (fun () ->
            let open Exercise in
            let s = push 2 (push 1 Empty_stack) in
            let (v, _rest) = pop s in
            Alcotest.(check int) "popped top" 2 v);
        Alcotest.test_case "pop and push round-trip" `Quick (fun () ->
            let open Exercise in
            let s0 = push 7 Empty_stack in
            let (v, _) = pop s0 in
            let s1 = push v Empty_stack in
            Alcotest.(check int) "round-trip" 7 (top s1)) ] );
    ( "Assignment 3: vhead and vtail",
      [ Alcotest.test_case "vhead of singleton vec" `Quick (fun () ->
            let open Exercise in
            let v = VCons (10, VNil) in
            Alcotest.(check int) "vhead is 10" 10 (vhead v));
        Alcotest.test_case "vtail vhead" `Quick (fun () ->
            let open Exercise in
            let v = VCons (1, VCons (2, VNil)) in
            Alcotest.(check int) "vhead of tail" 2 (vhead (vtail v)));
        Alcotest.test_case "vhead of string vec" `Quick (fun () ->
            let open Exercise in
            let v = VCons ("a", VCons ("b", VCons ("c", VNil))) in
            Alcotest.(check string) "head is a" "a" (vhead v);
            Alcotest.(check string) "second is b" "b" (vhead (vtail v))) ] );
    ( "Assignment 4: vec_to_list",
      [ Alcotest.test_case "VNil to empty list" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check (list int)) "empty vec" [] (vec_to_list VNil));
        Alcotest.test_case "singleton vec to list" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check (list int)) "singleton" [ 7 ] (vec_to_list (VCons (7, VNil))));
        Alcotest.test_case "three-element vec" `Quick (fun () ->
            let open Exercise in
            let v = VCons (1, VCons (2, VCons (3, VNil))) in
            Alcotest.(check (list int)) "three elements" [ 1; 2; 3 ] (vec_to_list v)) ] );
  ]
