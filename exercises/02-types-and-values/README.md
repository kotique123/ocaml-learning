# Exercise 02 — Types and Values

## Theory

### OCaml's static type system
OCaml is **statically and strongly typed**: every expression has a type known at compile time, and the compiler rejects programs that mix incompatible types. Unlike languages with implicit coercions, OCaml never silently converts an `int` to a `float` or a `char` to an `int`. This strictness catches many bugs early.

### The six primitive types
| Type     | Description                        | Example literals         |
|----------|------------------------------------|--------------------------|
| `int`    | Machine-width signed integer       | `0`, `42`, `-7`          |
| `float`  | IEEE-754 double-precision          | `3.14`, `-0.5`, `1e10`   |
| `bool`   | Boolean                            | `true`, `false`          |
| `char`   | Single ASCII character             | `'a'`, `'Z'`, `'\n'`     |
| `string` | Immutable byte sequence            | `"hello"`, `""`          |
| `unit`   | The "nothing" type, one value `()` | `()`                     |

### Explicit type annotations
You can annotate any expression with its type using `(expr : type)`:
```ocaml
let x : int = 42
let greet (name : string) : string = "Hello, " ^ name
```
Annotations are optional when the type can be inferred, but they serve as documentation and catch mismatches at the annotation site rather than deep inside the code.

### Conversion functions
Because OCaml does not coerce types automatically, explicit conversion functions are essential:

| Conversion            | Function            |
|-----------------------|---------------------|
| `int` → `string`      | `string_of_int`     |
| `string` → `int`      | `int_of_string`     |
| `float` → `int`       | `int_of_float` (truncates toward zero) |
| `int` → `float`       | `float_of_int`      |
| `bool` → `string`     | `string_of_bool`    |
| `char` → `int` (ASCII)| `Char.code`         |
| `int` → `char` (ASCII)| `Char.chr`          |

### Integer vs float arithmetic
Integer operators (`+`, `-`, `*`, `/`, `mod`) and float operators (`+.`, `-.`, `*.`, `/.`) are entirely separate. Using `+` on a `float` is a compile-time error. When you need mixed arithmetic, convert first:
```ocaml
let ratio = float_of_int 7 /. float_of_int 2   (* 3.5 *)
```

---

## Practice Assignments

### Assignment 1: int_to_string
Implement `int_to_string n` to convert an integer to its string representation.

### Assignment 2: float_to_int
Implement `float_to_int f` to truncate a float to an integer (toward zero).

### Assignment 3: char_to_code
Implement `char_to_code c` to return the ASCII code of a character as an integer.

### Assignment 4: code_to_char
Implement `code_to_char n` to return the character corresponding to ASCII code `n`.

### Assignment 5: is_digit
Implement `is_digit c` to return `true` if `c` is one of `'0'`–`'9'` and `false` otherwise. Hint: compare ASCII codes or use character comparison directly.

### Assignment 6: celsius_to_fahrenheit
Implement `celsius_to_fahrenheit c` to convert a Celsius temperature to Fahrenheit using the formula F = C × 9 / 5 + 32.
