let palindrome (s : string) : bool =
  let s = String.lowercase_ascii s in
  let n = String.length s in
  let rec check i =
    if i >= n / 2 then true
    else if s.[i] <> s.[n - 1 - i] then false
    else check (i + 1)
  in
  check 0

let word_wrap (text : string) (max_width : int) : string list =
  let words = String.split_on_char ' ' text in
  let buf = Buffer.create 64 in
  let lines = ref [] in
  List.iter
    (fun word ->
      let wlen = String.length word in
      let blen = Buffer.length buf in
      if blen = 0 then Buffer.add_string buf word
      else if blen + 1 + wlen <= max_width then begin
        Buffer.add_char buf ' ';
        Buffer.add_string buf word
      end else begin
        lines := Buffer.contents buf :: !lines;
        Buffer.clear buf;
        Buffer.add_string buf word
      end)
    words;
  if Buffer.length buf > 0 then lines := Buffer.contents buf :: !lines;
  List.rev !lines

let count_vowels (s : string) : int =
  String.fold_left
    (fun acc c -> if String.contains "aeiouAEIOU" c then acc + 1 else acc)
    0 s

let title_case (s : string) : string =
  let words = String.split_on_char ' ' s in
  let cap word =
    if String.length word = 0 then word
    else
      let first = String.make 1 (Char.uppercase_ascii word.[0]) in
      first ^ String.sub word 1 (String.length word - 1)
  in
  String.concat " " (List.map cap words)

let repeat_string (s : string) (n : int) : string =
  let buf = Buffer.create (String.length s * n) in
  for _ = 1 to n do
    Buffer.add_string buf s
  done;
  Buffer.contents buf

let csv_row (fields : string list) : string =
  let escape f = if String.contains f ',' then "\"" ^ f ^ "\"" else f in
  String.concat "," (List.map escape fields)
