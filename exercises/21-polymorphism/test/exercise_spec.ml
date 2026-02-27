open Exercise

let () =
  let open Alcotest in
  run "Polymorphism" [
    ( "Assignment 1: push and top",
      [ test_case "push onto empty stack" `Quick (fun () ->
            let s = push 1 Empty_stack in
            check int "top is 1" 1 (top s));
        test_case "push multiple elements" `Quick (fun () ->
            let s = push 3 (push 2 (push 1 Empty_stack)) in
            check int "top is last pushed" 3 (top s));
        test_case "push string" `Quick (fun () ->
            let s = push "hello" Empty_stack in
            check string "top string" "hello" (top s)) ] );
    ( "Assignment 2: pop",
      [ test_case "pop single element" `Quick (fun () ->
            let s = push 42 Empty_stack in
            let (v, _) = pop s in
            check int "popped value" 42 v);
        test_case "pop reveals top of two-element stack" `Quick (fun () ->
            let s = push 2 (push 1 Empty_stack) in
            let (v, _rest) = pop s in
            check int "popped top" 2 v);
        test_case "pop and push round-trip" `Quick (fun () ->
            let s0 = push 7 Empty_stack in
            let (v, _) = pop s0 in
            let s1 = push v Empty_stack in
            check int "round-trip" 7 (top s1)) ] );
    ( "Assignment 3: vhead and vtail",
      [ test_case "vhead of singleton vec" `Quick (fun () ->
            let v = VCons (10, VNil) in
            check int "vhead is 10" 10 (vhead v));
        test_case "vtail vhead" `Quick (fun () ->
            let v = VCons (1, VCons (2, VNil)) in
            check int "vhead of tail" 2 (vhead (vtail v)));
        test_case "vhead of string vec" `Quick (fun () ->
            let v = VCons ("a", VCons ("b", VCons ("c", VNil))) in
            check string "head is a" "a" (vhead v);
            check string "second is b" "b" (vhead (vtail v))) ] );
    ( "Assignment 4: vec_to_list",
      [ test_case "VNil to empty list" `Quick (fun () ->
            check (list int) "empty vec" [] (vec_to_list VNil));
        test_case "singleton vec to list" `Quick (fun () ->
            check (list int) "singleton" [ 7 ] (vec_to_list (VCons (7, VNil))));
        test_case "three-element vec" `Quick (fun () ->
            let v = VCons (1, VCons (2, VCons (3, VNil))) in
            check (list int) "three elements" [ 1; 2; 3 ] (vec_to_list v)) ] );
  ]
