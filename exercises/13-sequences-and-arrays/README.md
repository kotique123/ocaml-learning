# Exercise 13 — Sequences and Arrays

## Theory

Beyond lists, OCaml offers two further ways to work with ordered collections: **arrays** (mutable, random-access) and **`Seq`** (lazy, pull-based).

### Arrays

An array is a fixed-size, contiguous block of memory. Elements are accessed in O(1) by zero-based index, and the array can be mutated in place.

```ocaml
let arr = [| 1; 2; 3; 4 |]   (* array literal *)
let x   = arr.(2)              (* read element 2 → 3 *)
arr.(0) <- 99                  (* write element 0 *)
```

Key library functions: `Array.make`, `Array.init`, `Array.length`, `Array.map`, `Array.fold_left`, `Array.sub`, `Array.append`, `Array.copy`.

Use arrays when you need O(1) random access, in-place updates, or interoperability with C code. Prefer lists when you mostly prepend or pattern-match on the front.

### The `Seq` Module — Lazy Sequences

A `Seq.t` is a *thunk*: a `unit -> 'a Seq.node` function. Nodes are either `Seq.Nil` (empty) or `Seq.Cons (head, tail_thunk)`. Elements are computed **only when demanded** — the sequence is lazy.

This lets you define *infinite* sequences without allocating them upfront:

```ocaml
(* Integers from n upwards — infinite, but memory-safe *)
let rec from n () = Seq.Cons (n, from (n + 1))
```

### `Seq.unfold` — The Swiss Army Knife

```ocaml
(* state -> option (value * next_state) *)
Seq.unfold (fun s -> if finished s then None
                     else Some (value s, advance s)) initial
```

This is the general pattern for producing sequences from evolving state.

### Consuming Sequences

| Function | Effect |
|---|---|
| `Seq.take n seq` | First `n` elements as a new sequence |
| `Seq.to_list seq` | Materialise the whole sequence into a list |
| `Seq.map f seq` | Lazily apply `f` to each element |
| `Seq.filter p seq` | Lazily keep elements satisfying `p` |
| `Seq.fold_left f acc seq` | Left fold — forces the entire sequence |

### When to Use Which

| Structure | Access | Mutable | Lazy |
|---|---|---|---|
| `list` | O(n) | no | no |
| `array` | O(1) | yes | no |
| `Seq.t` | O(n) | no | yes |

## Practice Assignments

### Assignment 1: array_sum
Sum all elements of an integer array using `Array.fold_left`.
### Assignment 2: array_rotate
Return a new array rotated left by `n` positions.
### Assignment 3: running_total
Compute prefix sums: each element becomes the cumulative total so far.
### Assignment 4: naturals
Create an infinite lazy sequence of natural numbers starting at 0.
### Assignment 5: seq_take
Consume the first `n` elements of any sequence and return them as a list.
### Assignment 6: seq_squares
Generate the first `n` perfect squares (1, 4, 9, …) using sequences.
