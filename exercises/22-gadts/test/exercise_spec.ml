open Exercise

let () =
  let open Alcotest in
  run "GADTs" [
    ( "Assignment 1: eval int expressions",
      [ test_case "literal int" `Quick (fun () ->
            check int "42" 42 (eval (Lit_int 42)));
        test_case "add two literals" `Quick (fun () ->
            check int "3+4=7" 7 (eval (Add (Lit_int 3, Lit_int 4))));
        test_case "nested add" `Quick (fun () ->
            check int "1+2+3=6" 6
              (eval (Add (Add (Lit_int 1, Lit_int 2), Lit_int 3)))) ] );
    ( "Assignment 2: eval bool expressions",
      [ test_case "literal true" `Quick (fun () ->
            check bool "true" true (eval (Lit_bool true)));
        test_case "literal false" `Quick (fun () ->
            check bool "false" false (eval (Lit_bool false)));
        test_case "eq equal" `Quick (fun () ->
            check bool "1=1" true (eval (Eq (Lit_int 1, Lit_int 1))));
        test_case "eq not equal" `Quick (fun () ->
            check bool "1<>2" false (eval (Eq (Lit_int 1, Lit_int 2)))) ] );
    ( "Assignment 3: eval If expressions",
      [ test_case "if true picks then branch" `Quick (fun () ->
            check int "if true 1 2 = 1" 1
              (eval (If (Lit_bool true, Lit_int 1, Lit_int 2))));
        test_case "if false picks else branch" `Quick (fun () ->
            check int "if false 1 2 = 2" 2
              (eval (If (Lit_bool false, Lit_int 1, Lit_int 2))));
        test_case "if with eq condition" `Quick (fun () ->
            check int "if (1=1) 10 20 = 10" 10
              (eval (If (Eq (Lit_int 1, Lit_int 1), Lit_int 10, Lit_int 20)))) ] );
    ( "Assignment 4: hhead and htail",
      [ test_case "hhead of int-string hlist" `Quick (fun () ->
            let lst = HCons (1, HCons ("hello", HNil)) in
            check int "hhead is 1" 1 (hhead lst));
        test_case "htail then hhead" `Quick (fun () ->
            let lst = HCons (1, HCons ("hello", HNil)) in
            check string "second element" "hello" (hhead (htail lst)));
        test_case "hhead of bool-int hlist" `Quick (fun () ->
            let lst = HCons (true, HCons (42, HNil)) in
            check bool "hhead is true" true (hhead lst)) ] );
    ( "Assignment 5: hlength",
      [ test_case "empty hlist" `Quick (fun () ->
            check int "length 0" 0 (hlength HNil));
        test_case "singleton hlist" `Quick (fun () ->
            check int "length 1" 1 (hlength (HCons (42, HNil))));
        test_case "heterogeneous hlist of 3" `Quick (fun () ->
            let lst = HCons (1, HCons ("x", HCons (true, HNil))) in
            check int "length 3" 3 (hlength lst)) ] );
  ]
