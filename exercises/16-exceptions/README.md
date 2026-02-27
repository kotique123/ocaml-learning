# Exercise 16 — Exceptions

## Theory

OCaml exceptions are **lightweight and first-class**. Unlike Haskell, where errors often live in the `IO` monad, OCaml exceptions are a direct language feature: cheap to raise, automatically propagated up the call stack, and caught with `try...with`.

### Declaring exceptions

```ocaml
exception Division_by_zero_custom of string
exception Out_of_range of { index : int; length : int }
```

Any exception can carry a payload of any type. The `exception` keyword creates a new constructor of the built-in `exn` type.

### Raising and catching

```ocaml
let safe_div a b =
  if b = 0 then raise (Division_by_zero_custom "division by zero")
  else a / b

let result =
  try safe_div 10 0
  with Division_by_zero_custom msg -> Printf.printf "caught: %s\n" msg
```

`try...with` supports full pattern matching, including guards and wildcard patterns:

```ocaml
try f () with
| Not_found -> default
| Failure msg when String.length msg > 10 -> handle_long msg
| _ -> reraise ()
```

### Exceptions vs Result

| | Exceptions | `Result` |
|---|---|---|
| Performance | Very fast (no allocation on happy path) | Allocates `Ok`/`Error` |
| Composability | Implicit; can be forgotten | Explicit in the type |
| Best for | Truly exceptional/unexpected failures | Expected failure modes |

A common pattern is to bridge them: catch an exception and return a `Result`:

```ocaml
let try_div a b =
  match safe_div a b with
  | v -> Ok v
  | exception Division_by_zero_custom msg -> Error msg
```

### Resource cleanup with Fun.protect

```ocaml
Fun.protect ~finally:(fun () -> close_channel ch) (fun () ->
  (* work with ch *)
)
```

`Fun.protect` guarantees the `finally` thunk runs even if an exception is raised — OCaml's equivalent of `finally` blocks or RAII.

---

## Practice Assignments

**Assignment 1 — `safe_div`:** Implement `safe_div a b` that raises `Division_by_zero_custom "division by zero"` when `b = 0`.

**Assignment 2 — `safe_nth`:** Implement `safe_nth lst i` that raises `Out_of_range {index; length}` when `i` is out of bounds.

**Assignment 3 — `try_div`:** Implement `try_div a b` that returns `Ok (a/b)` or `Error msg` by catching `Division_by_zero_custom`.

**Assignment 4 — `with_default`:** Implement `with_default default f` that runs `f ()` and returns `default` if any exception escapes.

**Assignment 5 — `validate_age`:** Implement `validate_age n` that raises `Invalid_argument "age must be 0..150"` for out-of-range values.
