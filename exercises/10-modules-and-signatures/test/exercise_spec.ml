open Exercise

let () =
  Alcotest.run "Exercise 10 — modules-and-signatures"
    [ ( "Assignment 1: Stack"
      , [ Alcotest.test_case "empty stack is_empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty empty = true" true
                (Stack.is_empty Stack.empty))
        ; Alcotest.test_case "push then not empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty after push = false" false
                (Stack.is_empty (Stack.push 1 Stack.empty)))
        ; Alcotest.test_case "push and pop returns element" `Quick (fun () ->
              let s = Stack.push 42 Stack.empty in
              match Stack.pop s with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "popped value" 42 v)
        ; Alcotest.test_case "pop empty returns None" `Quick (fun () ->
              Alcotest.(check bool) "pop empty = None" true
                (Stack.pop Stack.empty = None))
        ; Alcotest.test_case "size of empty is 0" `Quick (fun () ->
              Alcotest.(check int) "size empty = 0" 0 (Stack.size Stack.empty))
        ; Alcotest.test_case "size after pushes" `Quick (fun () ->
              let s = Stack.push 3 (Stack.push 2 (Stack.push 1 Stack.empty)) in
              Alcotest.(check int) "size = 3" 3 (Stack.size s))
        ; Alcotest.test_case "LIFO order" `Quick (fun () ->
              let s = Stack.push 2 (Stack.push 1 Stack.empty) in
              match Stack.pop s with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "last in first out" 2 v)
        ] )
    ; ( "Assignment 2: Queue"
      , [ Alcotest.test_case "empty queue is_empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty empty = true" true
                (Queue.is_empty Queue.empty))
        ; Alcotest.test_case "enqueue then not empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty after enqueue = false" false
                (Queue.is_empty (Queue.enqueue 1 Queue.empty)))
        ; Alcotest.test_case "dequeue empty returns None" `Quick (fun () ->
              Alcotest.(check bool) "dequeue empty = None" true
                (Queue.dequeue Queue.empty = None))
        ; Alcotest.test_case "FIFO order" `Quick (fun () ->
              let q = Queue.enqueue 2 (Queue.enqueue 1 Queue.empty) in
              match Queue.dequeue q with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "first in first out" 1 v)
        ; Alcotest.test_case "size of empty is 0" `Quick (fun () ->
              Alcotest.(check int) "size empty = 0" 0 (Queue.size Queue.empty))
        ; Alcotest.test_case "size after enqueues" `Quick (fun () ->
              let q =
                Queue.enqueue 3 (Queue.enqueue 2 (Queue.enqueue 1 Queue.empty))
              in
              Alcotest.(check int) "size = 3" 3 (Queue.size q))
        ; Alcotest.test_case "enqueue then dequeue all" `Quick (fun () ->
              let q = Queue.enqueue 2 (Queue.enqueue 1 Queue.empty) in
              match Queue.dequeue q with
              | None -> Alcotest.fail "expected first element"
              | Some (_, q') ->
                (match Queue.dequeue q' with
                 | None -> Alcotest.fail "expected second element"
                 | Some (v, q'') ->
                   Alcotest.(check int) "second element" 2 v;
                   Alcotest.(check bool) "queue empty after all dequeues" true
                     (Queue.is_empty q'')))
        ] )
    ; ( "Assignment 3: Counter"
      , [ Alcotest.test_case "make and value" `Quick (fun () ->
              Alcotest.(check int) "make 5 value = 5" 5 (Counter.value (Counter.make 5)))
        ; Alcotest.test_case "increment" `Quick (fun () ->
              Alcotest.(check int)
                "make 0 |> increment |> value = 1"
                1
                (Counter.value (Counter.increment (Counter.make 0))))
        ; Alcotest.test_case "decrement" `Quick (fun () ->
              Alcotest.(check int)
                "make 5 |> decrement |> value = 4"
                4
                (Counter.value (Counter.decrement (Counter.make 5))))
        ; Alcotest.test_case "reset" `Quick (fun () ->
              Alcotest.(check int)
                "make 10 |> increment |> reset |> value = 10"
                10
                (Counter.value (Counter.reset (Counter.increment (Counter.make 10)))))
        ; Alcotest.test_case "increment twice" `Quick (fun () ->
              Alcotest.(check int)
                "make 0 |> increment |> increment |> value = 2"
                2
                (Counter.value
                   (Counter.increment (Counter.increment (Counter.make 0)))))
        ] )
    ]
