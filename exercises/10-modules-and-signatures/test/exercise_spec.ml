

let () =
  Alcotest.run "Exercise 10 — Modules and Signatures"
    [ ( "Assignment 1: Stack"
      , [ Alcotest.test_case "empty stack is_empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty empty = true" true
                (Exercise.Stack.is_empty Exercise.Stack.empty))
        ; Alcotest.test_case "push then not empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty after push = false" false
                (Exercise.Stack.is_empty (Exercise.Stack.push 1 Exercise.Stack.empty)))
        ; Alcotest.test_case "push and pop returns element" `Quick (fun () ->
              let s = Exercise.Stack.push 42 Exercise.Stack.empty in
              match Exercise.Stack.pop s with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "popped value" 42 v)
        ; Alcotest.test_case "pop empty returns None" `Quick (fun () ->
              Alcotest.(check bool) "pop empty = None" true
                (Exercise.Stack.pop Exercise.Stack.empty = None))
        ; Alcotest.test_case "size of empty is 0" `Quick (fun () ->
              Alcotest.(check int) "size empty = 0" 0 (Exercise.Stack.size Exercise.Stack.empty))
        ; Alcotest.test_case "size after pushes" `Quick (fun () ->
              let s = Exercise.Stack.push 3 (Exercise.Stack.push 2 (Exercise.Stack.push 1 Exercise.Stack.empty)) in
              Alcotest.(check int) "size = 3" 3 (Exercise.Stack.size s))
        ; Alcotest.test_case "LIFO order" `Quick (fun () ->
              let s = Exercise.Stack.push 2 (Exercise.Stack.push 1 Exercise.Stack.empty) in
              match Exercise.Stack.pop s with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "last in first out" 2 v)
        ] )
    ; ( "Assignment 2: Queue"
      , [ Alcotest.test_case "empty queue is_empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty empty = true" true
                (Exercise.Queue.is_empty Exercise.Queue.empty))
        ; Alcotest.test_case "enqueue then not empty" `Quick (fun () ->
              Alcotest.(check bool) "is_empty after enqueue = false" false
                (Exercise.Queue.is_empty (Exercise.Queue.enqueue 1 Exercise.Queue.empty)))
        ; Alcotest.test_case "dequeue empty returns None" `Quick (fun () ->
              Alcotest.(check bool) "dequeue empty = None" true
                (Exercise.Queue.dequeue Exercise.Queue.empty = None))
        ; Alcotest.test_case "FIFO order" `Quick (fun () ->
              let q = Exercise.Queue.enqueue 2 (Exercise.Queue.enqueue 1 Exercise.Queue.empty) in
              match Exercise.Queue.dequeue q with
              | None -> Alcotest.fail "expected Some"
              | Some (v, _) -> Alcotest.(check int) "first in first out" 1 v)
        ; Alcotest.test_case "size of empty is 0" `Quick (fun () ->
              Alcotest.(check int) "size empty = 0" 0 (Exercise.Queue.size Exercise.Queue.empty))
        ; Alcotest.test_case "size after enqueues" `Quick (fun () ->
              let q =
                Exercise.Queue.enqueue 3 (Exercise.Queue.enqueue 2 (Exercise.Queue.enqueue 1 Exercise.Queue.empty))
              in
              Alcotest.(check int) "size = 3" 3 (Exercise.Queue.size q))
        ; Alcotest.test_case "enqueue then dequeue all" `Quick (fun () ->
              let q = Exercise.Queue.enqueue 2 (Exercise.Queue.enqueue 1 Exercise.Queue.empty) in
              match Exercise.Queue.dequeue q with
              | None -> Alcotest.fail "expected first element"
              | Some (_, q') ->
                (match Exercise.Queue.dequeue q' with
                 | None -> Alcotest.fail "expected second element"
                 | Some (v, q'') ->
                   Alcotest.(check int) "second element" 2 v;
                   Alcotest.(check bool) "queue empty after all dequeues" true
                     (Exercise.Queue.is_empty q'')))
        ] )
    ; ( "Assignment 3: Counter"
      , [ Alcotest.test_case "make and value" `Quick (fun () ->
              Alcotest.(check int) "make 5 value = 5" 5 (Exercise.Counter.value (Exercise.Counter.make 5)))
        ; Alcotest.test_case "increment" `Quick (fun () ->
              Alcotest.(check int)
                "make 0 |> increment |> value = 1"
                1
                (Exercise.Counter.value (Exercise.Counter.increment (Exercise.Counter.make 0))))
        ; Alcotest.test_case "decrement" `Quick (fun () ->
              Alcotest.(check int)
                "make 5 |> decrement |> value = 4"
                4
                (Exercise.Counter.value (Exercise.Counter.decrement (Exercise.Counter.make 5))))
        ; Alcotest.test_case "reset" `Quick (fun () ->
              Alcotest.(check int)
                "make 10 |> increment |> reset |> value = 10"
                10
                (Exercise.Counter.value (Exercise.Counter.reset (Exercise.Counter.increment (Exercise.Counter.make 10)))))
        ; Alcotest.test_case "increment twice" `Quick (fun () ->
              Alcotest.(check int)
                "make 0 |> increment |> increment |> value = 2"
                2
                (Exercise.Counter.value
                   (Exercise.Counter.increment (Exercise.Counter.increment (Exercise.Counter.make 0)))))
        ] )
    ]
