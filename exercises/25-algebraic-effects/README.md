# Exercise 25 — Algebraic Effects

## Theory

### What Are Algebraic Effects?

**Algebraic effects** (OCaml 5 feature) are a structured mechanism for modelling side effects — logging, state, I/O, exceptions, async — without committing to a specific implementation. They separate *what* an effect does (its declaration) from *how* it is handled (its handler).

An effect is declared as a GADT constructor extending `Effect.t`:
```ocaml
type _ Effect.t += Log : string -> unit Effect.t
```

A computation performs an effect with `Effect.perform`:
```ocaml
Effect.perform (Log "hello")
```

### Resumable vs Exceptions

The key difference from exceptions is **resumability**. When an exception is raised, the call stack is unwound and cannot be resumed. When an effect is performed, the handler receives the *continuation* — a first-class value representing the rest of the computation. The handler can:

- **Resume** the continuation (`continue k value`) to resume the computation.
- **Abandon** it (return without calling `continue`) for early exit / abort.
- **Invoke it multiple times** for non-determinism or backtracking.

This makes effects strictly more expressive than exceptions.

### The Handler Pattern

`Effect.Deep.match_with f arg handler` runs `f arg` under a handler record with three fields:
- `retc`: called with the return value when `f` completes normally.
- `exnc`: called if `f` raises an exception.
- `effc`: called for each effect; returns `Some handler_fn` to handle it, or `None` to bubble it up.

### Comparison with Haskell Monads

Haskell models effects with monads, requiring the entire call stack to be written in monadic style. OCaml effects are **direct style** — ordinary-looking code can perform effects without any `>>=` plumbing. Handlers can be installed at any point and compose naturally.

### Practical Use Cases

Effects shine for: structured logging, dependency injection, mock I/O in tests, cooperative concurrency (the `eio` library), and transactional rollback.

---

## Practice Assignments

**Assignment 1 — run_with_log:** Handle `Log` effects by accumulating messages in a `ref list`. Resume the continuation with `()` after each log. Return the final result paired with the collected log lines.

**Assignment 2 — run_state:** Handle `Get` (resume with current state) and `Put` (update the `ref`, resume with `()`). Return the result paired with the final state.

**Assignment 3 — run_with_abort:** Handle `Abort` by *not* calling `continue` — simply return `default`. Any code after `Effect.perform Abort` is unreachable and never executes.
