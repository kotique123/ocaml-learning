# Exercise 05 — Conditionals

## Theory

### `if/then/else` as an expression
In OCaml, `if/then/else` is an **expression**, not a statement — it always produces a value:
```ocaml
let sign x = if x >= 0 then "non-negative" else "negative"
```
Both branches must have the **same type**. If the `else` branch is omitted, it implicitly returns `unit`, so the `then` branch must also be `unit`. This differs from languages like Python or JavaScript where `if` is purely a control-flow construct.

You can chain conditions:
```ocaml
if x < 0 then "negative"
else if x = 0 then "zero"
else "positive"
```

### Boolean operators
| Operator | Meaning                    | Short-circuits? |
|----------|----------------------------|-----------------|
| `&&`     | Logical AND                | Yes (lazy)      |
| `\|\|`   | Logical OR                 | Yes (lazy)      |
| `not`    | Logical NOT (prefix fn)    | N/A             |

`&&` and `||` **short-circuit**: the right-hand side is not evaluated if the result is already determined by the left-hand side. This matters when the right operand has side effects or could raise an exception.

### `match` with `when` guards
Sometimes `if/then/else` chains become unwieldy. A `match` expression with `when` guards can express the same logic more clearly:
```ocaml
match score with
| s when s >= 90 -> "A"
| s when s >= 80 -> "B"
| _              -> "C"
```
The arms are tested top-to-bottom; the first matching arm (whose guard is `true`) wins.

### Nested conditions
Conditions can be nested, but deep nesting is usually a sign that a `match` or helper function would be clearer. Prefer flat chains with `else if` or `match`/`when` over pyramids of nested `if` expressions.

### The modulo operator
`mod` computes the integer remainder: `n mod k = 0` means `n` is divisible by `k`. It is essential for divisibility checks like FizzBuzz and leap-year tests.

### Combining conditions
Complex Boolean conditions can be built from simpler ones:
```ocaml
let is_leap y =
  y mod 400 = 0 || (y mod 4 = 0 && y mod 100 <> 0)
```
Parentheses clarify precedence; `&&` binds tighter than `||`.

---

## Practice Assignments

### Assignment 1: abs_val
Implement `abs_val n` to return the absolute value of `n` using an `if/then/else` expression (do not use `abs` from the standard library).

### Assignment 2: clamp
Implement `clamp lo hi x` to return `x` clamped to the closed interval `[lo, hi]`: if `x < lo` return `lo`, if `x > hi` return `hi`, otherwise return `x`.

### Assignment 3: fizzbuzz
Implement `fizzbuzz n` to return `"FizzBuzz"` if `n` is divisible by 15, `"Fizz"` if divisible by 3, `"Buzz"` if divisible by 5, and `string_of_int n` otherwise.

### Assignment 4: grade
Implement `grade score` to return a letter grade: `"A"` for score ≥ 90, `"B"` for ≥ 80, `"C"` for ≥ 70, `"D"` for ≥ 60, and `"F"` otherwise.

### Assignment 5: leap_year
Implement `leap_year y` to return `true` if `y` is a leap year. A year is a leap year if it is divisible by 400, or divisible by 4 but not by 100.
