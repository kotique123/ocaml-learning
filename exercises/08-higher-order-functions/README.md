# Exercise 08 — Higher-Order Functions

## Theory

In OCaml, functions are **first-class values**: they can be passed as arguments,
returned from other functions, stored in data structures, and bound to names
just like integers or strings. Functions that take or return other functions are
called **higher-order functions**.

### Functions as Arguments

```ocaml
let apply f x = f x          (* takes a function f and applies it to x *)
let double x = x * 2
let result = apply double 5  (* 10 *)
```

### `List.map`, `List.filter`, `List.fold_left`

These three cover a huge fraction of list-processing tasks:

```ocaml
List.map    (fun x -> x * 2) [1; 2; 3]  (* [2; 4; 6] *)
List.filter (fun x -> x > 2) [1; 2; 3]  (* [3] *)
List.fold_left (+) 0 [1; 2; 3]          (* 6 *)
```

`fold_left` is the most general: both `map` and `filter` can be written with it.

### Function Composition

Composition chains functions together: `(f ∘ g)(x) = f(g(x))`.

```ocaml
let compose f g x = f (g x)
let add1_then_double = compose (fun x -> x * 2) (fun x -> x + 1)
add1_then_double 3  (* 8 *)
```

The standard library provides `Fun.compose` (OCaml ≥ 4.08).

### Currying and Partial Application

All OCaml functions are **curried** by default — a function of two arguments is
actually a function that takes one argument and returns a function:

```ocaml
let add x y = x + y       (* int -> int -> int *)
let add5 = add 5           (* partially applied: int -> int *)
add5 3                     (* 8 *)
```

Partial application lets you specialise generic functions without writing new
ones, and it is the foundation of point-free style.

### `List.for_all` and `List.exists`

```ocaml
List.for_all (fun x -> x > 0) [1; 2; 3]   (* true *)
List.exists  (fun x -> x < 0) [1; 2; -1]  (* true *)
```

---

## Practice Assignments

### Assignment 1: my_fold_left
Reimplement `List.fold_left` from scratch using pattern matching and recursion.
Signature: `my_fold_left : ('acc -> 'a -> 'acc) -> 'acc -> 'a list -> 'acc`.

### Assignment 2: compose
Write `compose : ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c` that composes two
functions. `compose f g x` should equal `f (g x)`.

### Assignment 3: apply_twice
Write `apply_twice : ('a -> 'a) -> 'a -> 'a` that applies a function to a
value, then applies it again to the result.

### Assignment 4: count_if
Write `count_if : ('a -> bool) -> 'a list -> int` that counts how many elements
of the list satisfy the predicate.

### Assignment 5: flat_map
Write `flat_map : ('a -> 'b list) -> 'a list -> 'b list` that maps a function
returning a list over each element, then flattens all the results into one list.

### Assignment 6: partition_by
Write `partition_by : ('a -> bool) -> 'a list -> 'a list * 'a list` that
splits a list into two: elements satisfying the predicate and those that don't.
Preserve the relative order within each group.

### Assignment 7: group_by
Write `group_by : int -> 'a list -> 'a list list` that splits a list into
consecutive chunks of size `n`. The final chunk may be smaller if the list
length is not a multiple of `n`.
