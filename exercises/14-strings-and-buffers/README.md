# Exercise 14 — Strings and Buffers

## Theory

### Strings in OCaml

OCaml strings (`string`) are **immutable sequences of bytes**. Once created, a string value cannot be changed — every operation that appears to "modify" a string actually allocates and returns a new one.

Key operations from the `String` module:

| Function | Purpose |
|---|---|
| `String.length s` | Byte count |
| `String.sub s pos len` | Extract a substring |
| `String.concat sep parts` | Join a list of strings with a separator |
| `String.split_on_char c s` | Split into a list on delimiter `c` |
| `String.trim s` | Remove leading and trailing whitespace |
| `String.uppercase_ascii` / `String.lowercase_ascii` | Case conversion (ASCII only) |

Note: `String.split_on_char` includes empty strings for consecutive delimiters.

### `Bytes` — Mutable Byte Sequences

When you need character-level mutation, use `bytes`:

```ocaml
let b = Bytes.of_string "hello"
Bytes.set b 0 'H'
let s = Bytes.to_string b   (* "Hello" *)
```

### `Buffer` — Efficient String Building

Repeatedly concatenating with `^` is **O(n²)** because each step copies all previous content into a new allocation. Use `Buffer` to accumulate pieces in amortised O(1) per addition:

```ocaml
let buf = Buffer.create 64        (* initial capacity hint *)
Buffer.add_string buf "Hello"
Buffer.add_char   buf ' '
Buffer.add_string buf "World"
let result = Buffer.contents buf  (* "Hello World" — one allocation *)
```

### `Printf.sprintf`

Build formatted strings without a `Buffer`:

```ocaml
let s = Printf.sprintf "%-10s = %d" "answer" 42
```

### Characters

`char` literals look like `'a'`. Useful functions: `Char.code`, `Char.chr`, `Char.lowercase_ascii`, `Char.uppercase_ascii`.

To capitalise the first character of a word:
```ocaml
let cap s =
  if String.length s = 0 then s
  else String.make 1 (Char.uppercase_ascii s.[0]) ^ String.sub s 1 (String.length s - 1)
```

## Practice Assignments

### Assignment 1: palindrome
Return `true` if a string reads the same forwards and backwards, ignoring case.
### Assignment 2: word_wrap
Split text into lines, keeping each line within a maximum character width.
### Assignment 3: count_vowels
Count vowel characters (`aeiouAEIOU`) in a string.
### Assignment 4: title_case
Capitalise the first letter of every space-separated word.
### Assignment 5: repeat_string
Repeat a string `n` times efficiently using `Buffer`.
### Assignment 6: csv_row
Join fields with commas, wrapping in double-quotes any field that itself contains a comma.
