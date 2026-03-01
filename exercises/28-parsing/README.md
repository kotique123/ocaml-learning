# Exercise 28 — Parser Combinators with Angstrom

## Theory

### What Are Parser Combinators?

A *parser combinator* library represents parsers as first-class values that can be composed with small combinators. Each combinator consumes some input and either succeeds (returning a value) or fails. Combinators are then combined to build more powerful parsers without writing a grammar file or a hand-rolled state machine.

### The Angstrom Library

[Angstrom](https://github.com/inhabitedtype/angstrom) is OCaml's most widely used parser combinator library. Its core type is `'a Angstrom.t` — a parser that produces a value of type `'a`.

Key combinators:

| Combinator | Description |
|---|---|
| `string s` | Match the literal string `s` |
| `char c` | Match a single character `c` |
| `satisfy pred` | Match one character satisfying `pred` |
| `many p` / `many1 p` | Zero or more / one or more repetitions of `p` |
| `choice [p1; p2; …]` | Try parsers in order, return first success |
| `sep_by sep p` | Parse `p` separated by `sep` |
| `map f p` | Transform the result of `p` with `f` |
| `p >>= f` | Monadic bind: pass result of `p` to `f` |
| `return v` | Succeed immediately with value `v` |
| `peek_char` | Look at next character without consuming |

### `let*` Desugaring

Angstrom supports the `let*` monadic binding syntax (OCaml 4.08+):

```ocaml
let* x = parse_int in
let* _ = char '+' in
let* y = parse_int in
return (x + y)
```

This is equivalent to `parse_int >>= fun x -> char '+' >>= fun _ -> ...`.

### Advantages Over Regex / Manual Parsing

- Composable: build complex parsers from small, tested pieces.
- Typed: the return type of each sub-parser is known at compile time.
- Readable: the combinator structure mirrors the grammar.
- Error-reporting: libraries like Angstrom provide position information on failure.

---

## Practice Assignments

### Assignment 1: parse_int
Implement a parser for an optionally-signed decimal integer. Use `satisfy`, `many1`, and `map`.

### Assignment 2: parse_csv_line
Implement a CSV line parser that handles unquoted and double-quoted fields (quoted fields may contain commas).

### Assignment 3: parse_json_bool
Implement a parser that recognises the literal strings `"true"` and `"false"` and returns a `bool`.

### Assignment 4: parse_list_of_ints
Implement a parser for `[1, 2, 3]` notation: a bracket-delimited, comma-separated list of integers.
