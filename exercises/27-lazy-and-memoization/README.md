# Exercise 27 — Lazy Evaluation and Memoization

## Theory

### Lazy Evaluation

OCaml is a *strict* (eager) language: function arguments are evaluated before the function body runs. The `lazy` keyword opts a specific expression into *lazy evaluation*: the expression is wrapped in a thunk and its value is computed only when explicitly demanded.

```ocaml
let v = lazy (expensive_computation ())  (* not run yet *)
let x = Lazy.force v                     (* run now, result cached *)
let y = Lazy.force v                     (* cached — not run again *)
```

The type of a lazy value is `'a Lazy.t` (or equivalently `'a lazy_t`). After the first `Lazy.force`, the result is *memoized* inside the `Lazy.t` cell, so subsequent forces return the cached value in O(1).

### Memoization

Memoization is a technique for caching the results of pure function calls so that repeated calls with the same argument return instantly. A common OCaml pattern:

```ocaml
let memoize f =
  let tbl = Hashtbl.create 16 in
  fun x ->
    match Hashtbl.find_opt tbl x with
    | Some v -> v
    | None   -> let v = f x in Hashtbl.add tbl x v; v
```

This is especially effective for recursive functions like Fibonacci when combined with a shared cache. Note that naive recursive memoization requires the cache to be defined outside the recursive call, or the function must be threaded through the cache.

### Lazy Sequences with `Seq`

The standard `Seq` module provides a *pull-based lazy stream* abstraction:

```ocaml
type 'a Seq.t = unit -> 'a Seq.node
type 'a Seq.node = Nil | Cons of 'a * 'a Seq.t
```

Because each step is a function call, sequences are computed on demand. This makes infinite sequences possible — you can define `lazy_fibs` as an infinite stream and safely take only the first N elements with `Seq.take`.

Key combinators: `Seq.cons`, `Seq.filter`, `Seq.take`, `Seq.map`, `List.of_seq`.

---

## Practice Assignments

### Assignment 1: force_once
Implement `force_once v` that forces a `lazy_t` value using `Lazy.force`.

### Assignment 2: memoize
Implement `memoize f` returning a version of `f` backed by a `Hashtbl` cache.

### Assignment 3: fib_memo
Implement `fib_memo n` using memoization so that `fib_memo 30` (and beyond) runs efficiently without exponential re-computation.

### Assignment 4: lazy_range
Implement `lazy_range lo hi` returning a `Seq.t` of integers `[lo, hi)`.

### Assignment 5: lazy_filter
Implement `lazy_filter pred seq` returning a lazy `Seq.t` containing only elements satisfying `pred`.

### Assignment 6: lazy_fibs
Implement `lazy_fibs ()` returning an infinite `Seq.t` of Fibonacci numbers `0, 1, 1, 2, 3, 5, …`. Use a helper that carries the pair `(a, b)` forward.
