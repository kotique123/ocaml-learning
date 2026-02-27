# Exercise 26 — Format and Pretty-Printing

## Theory

OCaml's `Format` module provides a structured pretty-printing engine that goes far beyond simple string concatenation. It is designed to handle automatic line-breaking and indentation through the concept of *formatting boxes* and *break hints*.

### Formatting Boxes

Boxes control how content is laid out when it doesn't fit on one line:

- **`hbox`** (horizontal box): all items on one line, no line breaks taken.
- **`vbox`** (vertical box): every break hint becomes a newline.
- **`hvbox`** (horizontal-or-vertical box): all on one line if it fits, otherwise all on separate lines.
- **`box`** (default box): breaks taken when the current line is full.

You open a box with `Format.pp_open_box` (or its variants) and close it with `Format.pp_close_box`. Break hints are inserted with `Format.pp_print_break` or the shorthand `Format.pp_print_space`.

### The `%a` Format Specifier

The `%a` specifier is the key to composable pretty-printers. Its type is:

```ocaml
%a : (formatter -> 'a -> unit) -> 'a -> unit
```

This means you pass a *printer function* and then the *value* to print. Because printers are just functions of type `formatter -> 'a -> unit`, they compose naturally:

```ocaml
Format.printf "%a" (pp_list pp_print_int) [1; 2; 3]
```

### Custom `pp_` Functions

By convention, pretty-printers are named `pp_<type>` and have the signature `formatter -> 'a -> unit`. This allows them to slot directly into `%a`, `Format.asprintf`, `Format.fprintf`, etc.

### Why Format over String Concatenation?

Manual string concatenation makes it hard to:
- Adapt output to the available line width automatically.
- Compose printers for nested data structures.
- Redirect output (to `stdout`, a buffer, a file, or a string) without changing the printer.

The `Format` module cleanly separates *what* to print from *where* to print it and *how wide* the output is.

---

## Practice Assignments

### Assignment 1 — `pp_list`
Implement `pp_list pp_elem ppf lst` that prints a list as `[e1; e2; e3]` using `pp_elem` for each element.

### Assignment 2 — `pp_tree`
Implement `pp_tree pp_val ppf t` for the provided binary tree type. Print `"."` for `Leaf` and `"(left val right)"` for `Node`.

### Assignment 3 — `pp_record`
Implement `pp_record ppf fields` that prints a `(string * string) list` as `{ key1 = val1; key2 = val2 }`.

### Assignment 4 — `format_table`
Implement `format_table headers rows` that returns an aligned ASCII table string. Compute the maximum width of each column and pad cells accordingly with a separator row of dashes between the header and the data rows.
