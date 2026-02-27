# Exercise 11 — Options and Results

## Theory

In many languages the absence of a value is represented by `null`, which causes runtime crashes whenever code forgets to check for it. OCaml eliminates this class of bugs by making the *possibility* of absence explicit in the type system through algebraic data types.

### The `option` Type

```ocaml
type 'a option = None | Some of 'a
```

A value of type `int option` is *either* `None` (nothing here) *or* `Some n` (a value `n`). The compiler forces you to handle both cases in every `match`, so "forgetting to check" is a type error, not a runtime surprise.

The standard library provides composable helpers so you rarely need to write `match` by hand:

| Function | Behaviour |
|---|---|
| `Option.map f opt` | Apply `f` inside `Some`, return `None` unchanged |
| `Option.bind opt f` | Chain option-returning functions ("flatMap") |
| `Option.value opt ~default` | Unwrap with a fallback |
| `Option.fold ~none ~some opt` | Eliminate with two branches |

### The `result` Type

When failure carries a reason you want to communicate, use `result`:

```ocaml
type ('a, 'e) result = Ok of 'a | Error of 'e
```

`Result.map` and `Result.bind` work like their `option` counterparts: they thread `Ok` values through a pipeline and short-circuit on the first `Error`, propagating it unchanged to the end.

### Choosing Between `option` and `result`

- Use **`option`** when absence needs no explanation (e.g., looking up a key that might not exist).
- Use **`result`** when failure carries diagnostic information (e.g., parsing user input or validating data).

### Chaining with `bind`

Both `option_bind` and `result_bind` support monadic chaining: if the first computation succeeds feed its value to the next; otherwise propagate the failure. This replaces deeply nested `match` trees with a flat, readable pipeline.

```ocaml
let result =
  option_bind (safe_div 100 x) (fun q ->
  option_bind (safe_sqrt (float_of_int q)) (fun r ->
  Some r))
```

## Practice Assignments

1. **Assignment 1: safe_div** — Implement safe integer division returning `None` when the divisor is zero.
2. **Assignment 2: safe_sqrt** — Implement safe square root returning `None` for negative inputs.
3. **Assignment 3: option_map** — Implement `option_map` using only `match`, without `Option.map`.
4. **Assignment 4: option_bind** — Implement `option_bind` (monadic bind for options).
5. **Assignment 5: parse_int** — Convert a string to an integer, returning an `Error` message on failure.
6. **Assignment 6: result_map** — Implement `result_map`, leaving `Error` values untouched.
7. **Assignment 7: chain_divs** — Chain two safe divisions using `option_bind`.
