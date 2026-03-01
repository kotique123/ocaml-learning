let () =
  Alcotest.run "Exercise 22 — GADTs" [
    ( "Assignment 1: eval int expressions",
      [ Alcotest.test_case "literal int" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "42" 42 (eval (Lit_int 42)));
        Alcotest.test_case "add two literals" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "3+4=7" 7 (eval (Add (Lit_int 3, Lit_int 4))));
        Alcotest.test_case "nested add" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "1+2+3=6" 6
              (eval (Add (Add (Lit_int 1, Lit_int 2), Lit_int 3)))) ] );
    ( "Assignment 2: eval bool expressions",
      [ Alcotest.test_case "literal true" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "true" true (eval (Lit_bool true)));
        Alcotest.test_case "literal false" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "false" false (eval (Lit_bool false)));
        Alcotest.test_case "eq equal" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "1=1" true (eval (Eq (Lit_int 1, Lit_int 1))));
        Alcotest.test_case "eq not equal" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check bool) "1<>2" false (eval (Eq (Lit_int 1, Lit_int 2)))) ] );
    ( "Assignment 3: eval If expressions",
      [ Alcotest.test_case "if true picks then branch" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "if true 1 2 = 1" 1
              (eval (If (Lit_bool true, Lit_int 1, Lit_int 2))));
        Alcotest.test_case "if false picks else branch" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "if false 1 2 = 2" 2
              (eval (If (Lit_bool false, Lit_int 1, Lit_int 2))));
        Alcotest.test_case "if with eq condition" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "if (1=1) 10 20 = 10" 10
              (eval (If (Eq (Lit_int 1, Lit_int 1), Lit_int 10, Lit_int 20)))) ] );
    ( "Assignment 4: hhead and htail",
      [ Alcotest.test_case "hhead of int-string hlist" `Quick (fun () ->
            let open Exercise in
            let lst = HCons (1, HCons ("hello", HNil)) in
            Alcotest.(check int) "hhead is 1" 1 (hhead lst));
        Alcotest.test_case "htail then hhead" `Quick (fun () ->
            let open Exercise in
            let lst = HCons (1, HCons ("hello", HNil)) in
            Alcotest.(check string) "second element" "hello" (hhead (htail lst)));
        Alcotest.test_case "hhead of bool-int hlist" `Quick (fun () ->
            let open Exercise in
            let lst = HCons (true, HCons (42, HNil)) in
            Alcotest.(check bool) "hhead is true" true (hhead lst)) ] );
    ( "Assignment 5: hlength",
      [ Alcotest.test_case "empty hlist" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "length 0" 0 (hlength HNil));
        Alcotest.test_case "singleton hlist" `Quick (fun () ->
            let open Exercise in
            Alcotest.(check int) "length 1" 1 (hlength (HCons (42, HNil))));
        Alcotest.test_case "heterogeneous hlist of 3" `Quick (fun () ->
            let open Exercise in
            let lst = HCons (1, HCons ("x", HCons (true, HNil))) in
            Alcotest.(check int) "length 3" 3 (hlength lst)) ] );
  ]
