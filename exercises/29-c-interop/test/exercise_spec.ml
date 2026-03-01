open Bigarray

let buf_to_list buf =
  let n = Array1.dim buf in
  List.init n (fun i -> buf.{i})

(* shorthand to avoid Bigarray.int shadowing Alcotest.int testable *)
let int_t = Alcotest.int
let list_int_t = Alcotest.(list int)
let string_t = Alcotest.string
let bytes_t = Alcotest.bytes

(* ── Assignment 1: create_buffer ────────────────────────────────────────── *)

let test_create_buffer_size () =
  let buf = Exercise.create_buffer 8 in
  Alcotest.(check int_t) "size 8" 8 (Array1.dim buf)

let test_create_buffer_zeroed () =
  let buf = Exercise.create_buffer 4 in
  Alcotest.(check list_int_t) "zero filled" [0;0;0;0] (buf_to_list buf)

let test_create_buffer_zero_len () =
  let buf = Exercise.create_buffer 0 in
  Alcotest.(check int_t) "size 0" 0 (Array1.dim buf)

(* ── Assignment 2: buffer_fill ──────────────────────────────────────────── *)

let test_buffer_fill_value () =
  let buf = Exercise.create_buffer 3 in
  Exercise.buffer_fill buf 7;
  Alcotest.(check list_int_t) "all 7s" [7;7;7] (buf_to_list buf)

let test_buffer_fill_zero () =
  let buf = Exercise.create_buffer 3 in
  Exercise.buffer_fill buf 255;
  Exercise.buffer_fill buf 0;
  Alcotest.(check list_int_t) "zeroed again" [0;0;0] (buf_to_list buf)

let test_buffer_fill_boundary () =
  let buf = Exercise.create_buffer 2 in
  Exercise.buffer_fill buf 255;
  Alcotest.(check list_int_t) "max byte" [255;255] (buf_to_list buf)

(* ── Assignment 3: buffer_sum ───────────────────────────────────────────── *)

let test_buffer_sum_zeros () =
  let buf = Exercise.create_buffer 5 in
  Alcotest.(check int_t) "sum zeros" 0 (Exercise.buffer_sum buf)

let test_buffer_sum_filled () =
  let buf = Exercise.create_buffer 4 in
  Exercise.buffer_fill buf 3;
  Alcotest.(check int_t) "sum of 3*4" 12 (Exercise.buffer_sum buf)

let test_buffer_sum_mixed () =
  let buf = Exercise.create_buffer 3 in
  buf.{0} <- 10; buf.{1} <- 20; buf.{2} <- 30;
  Alcotest.(check int_t) "sum 10+20+30" 60 (Exercise.buffer_sum buf)

(* ── Assignment 4: buffer_to_string and bytes_to_buffer ─────────────────── *)

let test_buffer_to_string () =
  let buf = Exercise.create_buffer 3 in
  buf.{0} <- Char.code 'A';
  buf.{1} <- Char.code 'B';
  buf.{2} <- Char.code 'C';
  let b = Exercise.buffer_to_string buf in
  Alcotest.(check string_t) "ABC" "ABC" (Bytes.to_string b)

let test_bytes_to_buffer () =
  let b = Bytes.of_string "XYZ" in
  let buf = Exercise.bytes_to_buffer b in
  Alcotest.(check int_t) "length" 3 (Array1.dim buf);
  Alcotest.(check int_t) "X" (Char.code 'X') buf.{0};
  Alcotest.(check int_t) "Y" (Char.code 'Y') buf.{1};
  Alcotest.(check int_t) "Z" (Char.code 'Z') buf.{2}

let test_roundtrip () =
  let original = Bytes.of_string "Hello" in
  let buf = Exercise.bytes_to_buffer original in
  let back = Exercise.buffer_to_string buf in
  Alcotest.(check bytes_t) "roundtrip" original back

(* ── Assignment 5: xor_buffers ──────────────────────────────────────────── *)

let test_xor_basic () =
  let a = Exercise.create_buffer 3 in
  let b = Exercise.create_buffer 3 in
  a.{0} <- 0xFF; a.{1} <- 0xAB; a.{2} <- 0x00;
  b.{0} <- 0xFF; b.{1} <- 0x00; b.{2} <- 0xAB;
  let r = Exercise.xor_buffers a b in
  Alcotest.(check list_int_t) "xor result" [0x00; 0xAB; 0xAB] (buf_to_list r)

let test_xor_self () =
  let a = Exercise.create_buffer 4 in
  Exercise.buffer_fill a 123;
  let r = Exercise.xor_buffers a a in
  Alcotest.(check list_int_t) "xor self = zeros" [0;0;0;0] (buf_to_list r)

let test_xor_identity () =
  let a = Exercise.create_buffer 3 in
  a.{0} <- 5; a.{1} <- 10; a.{2} <- 15;
  let zero = Exercise.create_buffer 3 in
  let r = Exercise.xor_buffers a zero in
  Alcotest.(check list_int_t) "xor with zeros" [5;10;15] (buf_to_list r)

(* ── Runner ─────────────────────────────────────────────────────────────── *)

let () =
  Alcotest.run "Exercise 29 — C Interop"
    [ ( "Assignment 1: create_buffer",
        [ Alcotest.test_case "correct size"    `Quick test_create_buffer_size;
          Alcotest.test_case "zero-filled"     `Quick test_create_buffer_zeroed;
          Alcotest.test_case "zero length"     `Quick test_create_buffer_zero_len ] );
      ( "Assignment 2: buffer_fill",
        [ Alcotest.test_case "fill value"   `Quick test_buffer_fill_value;
          Alcotest.test_case "fill zero"    `Quick test_buffer_fill_zero;
          Alcotest.test_case "fill max"     `Quick test_buffer_fill_boundary ] );
      ( "Assignment 3: buffer_sum",
        [ Alcotest.test_case "sum zeros"  `Quick test_buffer_sum_zeros;
          Alcotest.test_case "sum filled" `Quick test_buffer_sum_filled;
          Alcotest.test_case "sum mixed"  `Quick test_buffer_sum_mixed ] );
      ( "Assignment 4: buffer_to_string and bytes_to_buffer",
        [ Alcotest.test_case "to_string"     `Quick test_buffer_to_string;
          Alcotest.test_case "bytes_to_buf"  `Quick test_bytes_to_buffer;
          Alcotest.test_case "roundtrip"     `Quick test_roundtrip ] );
      ( "Assignment 5: xor_buffers",
        [ Alcotest.test_case "xor basic"    `Quick test_xor_basic;
          Alcotest.test_case "xor self"     `Quick test_xor_self;
          Alcotest.test_case "xor identity" `Quick test_xor_identity ] ) ]
