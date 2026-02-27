# Exercise 20 — Tail Recursion

## Theory

Every function call consumes a **stack frame**. On a naive recursive function over a list of one million elements, you allocate one million frames — eventually causing a stack overflow (`Stack_overflow` exception in OCaml).

### Tail call position

A call is in **tail position** when it is the very last thing a function does before returning — there is no further work pending in the caller. OCaml (and most functional language compilers) optimize tail calls into **jumps**, reusing the current stack frame instead of allocating a new one.

```ocaml
(* NOT tail-recursive: must add 1 to the result after the recursive call *)
let rec sum_naive = function
  | [] -> 0
  | x :: xs -> x + sum_naive xs   (* + happens after the call *)

(* Tail-recursive: accumulator carries the result; recursive call is last *)
let sum_tr lst =
  let rec go acc = function
    | [] -> acc
    | x :: xs -> go (acc + x) xs  (* go is in tail position *)
  in
  go 0 lst
```

### The accumulator pattern

Thread an extra argument (the accumulator) through the recursion. The base case returns the accumulator directly. This is the most common technique for making recursion tail-recursive.

### `List.rev_append` and `fold_left` vs `fold_right`

`List.fold_left` is tail-recursive; `List.fold_right` is **not** (it processes the list from right to left and must keep frames on the stack). Prefer `fold_left` when possible, reversing the result with `List.rev` if needed. `List.rev_append acc rest` appends `rest` to the reverse of `acc` in a single tail-recursive pass.

### When does it matter?

- Lists shorter than ~10 000 elements: usually fine either way.
- Lists of 100 000+ elements: use tail-recursive versions to avoid `Stack_overflow`.
- OCaml's default stack is ~8 MB; each frame is roughly 16–64 bytes depending on the function.

---

## Practice Assignments

**Assignment 1 — `sum_naive`:** Implement a naive (non-tail-recursive) sum using direct recursion.

**Assignment 2 — `sum_tr`:** Implement a tail-recursive sum using an accumulator helper.

**Assignment 3 — `reverse_tr`:** Implement `reverse_tr` using tail recursion (hint: accumulator).

**Assignment 4 — `flatten_tr`:** Implement `flatten_tr` to flatten a list of lists tail-recursively (hint: `List.rev_append`).

**Assignment 5 — `map_tr`:** Implement `map_tr f lst` tail-recursively; remember to reverse the accumulated result.

**Assignment 6 — `fibonacci_tr`:** Implement `fibonacci_tr n` with a tail-recursive helper carrying two accumulators (`a` and `b`).

**Assignment 7 — `range`:** Implement `range lo hi` returning `[lo; lo+1; ...; hi-1]` tail-recursively.
