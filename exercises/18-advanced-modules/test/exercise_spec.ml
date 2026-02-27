module IntPQ = Exercise.PriorityQueue(Int)

let () =
  Alcotest.run "Exercise 18 — Advanced Modules"
    [ ( "Assignment 1: PriorityQueue",
        [ Alcotest.test_case "empty has size 0" `Quick (fun () ->
              Alcotest.(check int) "size 0" 0 (IntPQ.size IntPQ.empty));
          Alcotest.test_case "pop_min on empty returns None" `Quick (fun () ->
              Alcotest.(check (option (pair int (result unit unit)))) "none" None
                (Option.map (fun (v, _) -> (v, Ok ())) (IntPQ.pop_min IntPQ.empty)));
          Alcotest.test_case "insert increases size" `Quick (fun () ->
              let q = IntPQ.insert 3 IntPQ.empty in
              let q = IntPQ.insert 1 q in
              Alcotest.(check int) "size 2" 2 (IntPQ.size q));
          Alcotest.test_case "pop_min returns smallest" `Quick (fun () ->
              let q = IntPQ.insert 5 IntPQ.empty in
              let q = IntPQ.insert 2 q in
              let q = IntPQ.insert 8 q in
              match IntPQ.pop_min q with
              | None -> Alcotest.fail "expected Some"
              | Some (v, rest) ->
                Alcotest.(check int) "min is 2" 2 v;
                Alcotest.(check int) "rest has size 2" 2 (IntPQ.size rest));
          Alcotest.test_case "sorted extraction" `Quick (fun () ->
              let q = List.fold_left (fun acc x -> IntPQ.insert x acc)
                        IntPQ.empty [4;1;7;2;9;3] in
              let rec drain acc q =
                match IntPQ.pop_min q with
                | None -> List.rev acc
                | Some (v, rest) -> drain (v :: acc) rest
              in
              Alcotest.(check (list int)) "sorted" [1;2;3;4;7;9] (drain [] q)) ] );
      ( "Assignment 2: RingBuffer",
        [ Alcotest.test_case "make has correct capacity" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 5 in
              Alcotest.(check int) "capacity 5" 5 (Exercise.RingBuffer.capacity rb));
          Alcotest.test_case "make is empty" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 3 in
              Alcotest.(check int) "size 0" 0 (Exercise.RingBuffer.size rb));
          Alcotest.test_case "push increases size" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 3 in
              let rb = Exercise.RingBuffer.push 1 rb in
              let rb = Exercise.RingBuffer.push 2 rb in
              Alcotest.(check int) "size 2" 2 (Exercise.RingBuffer.size rb));
          Alcotest.test_case "to_list preserves order" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 5 in
              let rb = Exercise.RingBuffer.push 1 rb in
              let rb = Exercise.RingBuffer.push 2 rb in
              let rb = Exercise.RingBuffer.push 3 rb in
              Alcotest.(check (list int)) "order" [1;2;3]
                (Exercise.RingBuffer.to_list rb));
          Alcotest.test_case "drops oldest when full" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 3 in
              let rb = Exercise.RingBuffer.push 1 rb in
              let rb = Exercise.RingBuffer.push 2 rb in
              let rb = Exercise.RingBuffer.push 3 rb in
              let rb = Exercise.RingBuffer.push 4 rb in
              Alcotest.(check int) "size still 3" 3 (Exercise.RingBuffer.size rb);
              Alcotest.(check (list int)) "oldest dropped" [2;3;4]
                (Exercise.RingBuffer.to_list rb));
          Alcotest.test_case "overflow by more than capacity" `Quick (fun () ->
              let rb = Exercise.RingBuffer.make 2 in
              let rb = Exercise.RingBuffer.push 10 rb in
              let rb = Exercise.RingBuffer.push 20 rb in
              let rb = Exercise.RingBuffer.push 30 rb in
              let rb = Exercise.RingBuffer.push 40 rb in
              Alcotest.(check (list int)) "last two" [30;40]
                (Exercise.RingBuffer.to_list rb)) ] ) ]
