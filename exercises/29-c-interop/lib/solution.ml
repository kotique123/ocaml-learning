open Bigarray

type buffer = (int, int8_unsigned_elt, c_layout) Array1.t

let create_buffer (n : int) : buffer =
  Array1.create int8_unsigned c_layout n |> fun buf ->
  Array1.fill buf 0;
  buf

let buffer_fill (buf : buffer) (v : int) : unit =
  Array1.fill buf v

let buffer_sum (buf : buffer) : int =
  let n = Array1.dim buf in
  let s = ref 0 in
  for i = 0 to n - 1 do s := !s + buf.{i} done;
  !s

let buffer_to_string (buf : buffer) : bytes =
  let n = Array1.dim buf in
  Bytes.init n (fun i -> Char.chr buf.{i})

let bytes_to_buffer (b : bytes) : buffer =
  let n = Bytes.length b in
  let buf = Array1.create int8_unsigned c_layout n in
  Bytes.iteri (fun i c -> buf.{i} <- Char.code c) b;
  buf

let xor_buffers (a : buffer) (b : buffer) : buffer =
  let n = Array1.dim a in
  let r = Array1.create int8_unsigned c_layout n in
  for i = 0 to n - 1 do r.{i} <- a.{i} lxor b.{i} done;
  r
