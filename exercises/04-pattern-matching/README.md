# Exercise 04 — Pattern Matching

## Theory

### The `match` expression
Pattern matching is one of OCaml's most powerful features. A `match` expression tests a value against a sequence of **patterns** and evaluates the expression on the right of the first matching `->`:
```ocaml
match n with
| 0 -> "zero"
| 1 -> "one"
| _ -> "many"
```
`match` is an **expression** — it produces a value, and all branches must have the same type.

### Exhaustiveness
The OCaml compiler checks that patterns cover all possible cases. A non-exhaustive match produces a **warning** (and may raise `Match_failure` at runtime). Always handle every constructor of a type or use a wildcard `_` to catch remaining cases.

### Wildcard and variable patterns
- `_` matches anything and discards the value.
- A plain name like `n` matches anything and **binds** the value to that name.

### Tuple patterns
Tuples can be destructured directly in patterns:
```ocaml
match pair with
| (0, 0) -> "origin"
| (x, 0) -> "on x-axis at " ^ string_of_int x
| (0, y) -> "on y-axis at " ^ string_of_int y
| (x, y) -> "at " ^ string_of_int x ^ ", " ^ string_of_int y
```

### Constructor patterns
Variant types are matched by their constructors:
```ocaml
type color = Red | Green | Blue
match c with
| Red   -> "red"
| Green -> "green"
| Blue  -> "blue"
```
Constructors carrying data are matched with their payloads: `Circle r`, `Rectangle (w, h)`.

### `as`-patterns
An `as` pattern matches the whole structure **and** binds it to a name:
```ocaml
match shape with
| (Circle _ as s) -> process s
```

### `when` guards
A `when` clause adds an extra boolean condition to a pattern arm:
```ocaml
match n with
| x when x < 0 -> "negative"
| 0             -> "zero"
| _             -> "positive"
```
The arm is only taken when both the pattern matches **and** the guard is `true`.

### Nested patterns
Patterns can be nested arbitrarily deep, allowing you to match on the structure of complex data in a single `match` expression.

---

## Practice Assignments

### Assignment 1: describe_int
Implement `describe_int n` to return `"negative"`, `"zero"`, or `"positive"` based on `n`.

### Assignment 2: fst_of_triple
Implement `fst_of_triple t` to extract the first element of a 3-tuple using a tuple pattern.

### Assignment 3: classify_pair
Implement `classify_pair p` to return `"both zero"`, `"first zero"`, `"second zero"`, or `"neither zero"` by matching on the pair `(a, b)`.

### Assignment 4: area
Implement `area s` for the `shape` type defined in the file. Use constructor patterns for `Circle`, `Rectangle`, and `Triangle`. For the triangle, apply Heron's formula.

### Assignment 5: is_right_triangle
Implement `is_right_triangle a b c` (where `c` is the hypotenuse) to return `true` when the Pythagorean theorem holds within a tolerance of `1e-9`.
