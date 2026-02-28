# Exercise 01 — Hello OCaml

## Theory

### The utop REPL
OCaml ships with **utop**, an interactive top-level (REPL) where you can type expressions and see their values immediately. Start it by running `utop` in your terminal. Every expression must be terminated with `;;` to be evaluated. utop is ideal for experimenting: try arithmetic, call functions, and inspect types on the spot.

### Printing output
OCaml provides two main ways to print to standard output:

- `print_endline : string -> unit` — prints a string followed by a newline. Simple and idiomatic for plain text.
- `Printf.printf : ('a, out_channel, unit) format -> 'a` — a C-style formatted printer. Use format specifiers like `%s` (string), `%d` (integer), `%f` (float), and `%b` (bool). Example: `Printf.printf "Hello, %s! You are %d years old.\n" "Alice" 30`.

### Let bindings
Values are bound to names with `let`:
```ocaml
let x = 42
let message = "Hello"
```
Inside expressions, use `let … in`:
```ocaml
let result =
  let a = 3 in
  let b = 4 in
  a + b
```
Bindings in OCaml are **immutable by default** — once bound, `x` cannot be reassigned.

### String concatenation
Strings are concatenated with the `^` operator:
```ocaml
let greeting = "Hello, " ^ "World" ^ "!"
```
Note: `^` only works on strings. To concatenate a number into a string, convert it first with `string_of_int` or `string_of_float`.

### Arithmetic operators
OCaml keeps integer and floating-point arithmetic strictly separate:

| Operation | Integer | Float  |
|-----------|---------|--------|
| Add       | `+`     | `+.`   |
| Subtract  | `-`     | `-.`   |
| Multiply  | `*`     | `*.`   |
| Divide    | `/`     | `/.`   |
| Modulo    | `mod`   | —      |

Mixing `int` and `float` with the same operator is a **type error**. Use `float_of_int` to convert when needed.

### Float.pi
The standard library provides `Float.pi` (≈ 3.14159265358979…) for use in floating-point calculations.

### Conditionals
OCaml's `if` expression returns a value — both branches must have the same type:
```ocaml
let classify score =
  if score >= 90.0 then "A"
  else if score >= 80.0 then "B"
  else "C"
```
For numeric comparisons on `float` values, use `>=`, `>`, `<=`, `<`. There is no separate `elsif` keyword — chain conditions with `else if`. Every `if` that isn't `unit` must have a matching `else`.

---

## Practice Assignments

### Assignment 1: greet
Implement `greet name` so that it returns the string `"Hello, " ^ name ^ "!"`.

### Assignment 2: double
Implement `double n` so that it returns `n` multiplied by 2 using integer arithmetic.

### Assignment 3: circle_area
Implement `circle_area r` so that it returns the area of a circle with radius `r`. The formula is π × r². Use `Float.pi` for the value of π.

### Assignment 4: bmi
Implement `bmi weight height` to compute the Body Mass Index (BMI = weight / height²) and classify the result as `"Underweight"` (BMI < 18.5), `"Normal"` (18.5 ≤ BMI < 25.0), or `"Overweight"` (BMI ≥ 25.0).
