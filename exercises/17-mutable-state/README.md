# Exercise 17 — Mutable State

## Theory

OCaml is a **functional-first** language, but mutation is fully supported and explicit. You must opt in — pure values are immutable by default, and the type system makes mutable state visible.

### Ref cells

The simplest mutable value is a `ref`:

```ocaml
let counter = ref 0
counter := !counter + 1   (* := assigns, ! dereferences *)
incr counter              (* shorthand for counter := !counter + 1 *)
```

A `ref` is really just a record `{ mutable contents : 'a }`.

### Mutable record fields

```ocaml
type point = { mutable x : float; mutable y : float }
let p = { x = 0.0; y = 0.0 }
p.x <- 3.14
```

Only fields declared `mutable` can be assigned. This keeps the surface area of mutation explicit.

### Arrays

Arrays are mutable, O(1) random-access structures:

```ocaml
let arr = [|1; 2; 3|]
arr.(1) <- 99       (* mutation *)
let v = arr.(0)     (* access *)
```

Use `Array.make`, `Array.init`, `Array.blit` for common operations.

### Hashtbl — imperative hash maps

```ocaml
let tbl : (string, int) Hashtbl.t = Hashtbl.create 16
Hashtbl.add tbl "key" 42
let v = Hashtbl.find tbl "key"   (* raises Not_found if absent *)
let v = Hashtbl.find_opt tbl "key"   (* returns option *)
```

`Hashtbl` is the go-to choice when you need a mutable, O(1) dictionary. For persistent (immutable) maps, prefer `Map.Make`.

### Queue and Stack

OCaml's standard library provides imperative `Queue` and `Stack` modules with the expected `push`/`pop`/`peek` operations. Both use mutable doubly-linked lists / arrays internally.

---

## Practice Assignments

**Assignment 1 — `swap`:** Implement `swap r1 r2` that exchanges the contents of two `ref` cells.

**Assignment 2 — `array_fill_range`:** Implement `array_fill_range arr lo hi v` that sets every position from `lo` to `hi` (inclusive) to `v`.

**Assignment 3 — `histogram`:** Implement `histogram lst` returning a `Hashtbl` mapping each element to its count.

**Assignment 4 — `dedup_array`:** Implement `dedup_array arr` returning a new array with consecutive duplicates removed.

**Assignment 5 — `queue_rotate`:** Implement `queue_rotate q n` that moves the front element to the back `n` times, modifying `q` in place.
