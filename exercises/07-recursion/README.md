# Exercise 07 — Recursion

## Theory

Recursion is the primary mechanism for iteration in OCaml. Instead of `for` or
`while` loops (which exist but are rarely idiomatic), you write functions that
call themselves.

### The `let rec` Keyword

To define a recursive function, you must use `let rec`:

```ocaml
let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1)
```

Without `rec`, a function cannot refer to itself by name.

### Base Case and Recursive Case

Every well-formed recursive function has:

1. **Base case(s)** — inputs where the function returns directly without
   recursing (e.g., `n = 0` for factorial, `[]` for list functions).
2. **Recursive case(s)** — inputs where the function reduces the problem and
   calls itself on a smaller sub-problem.

Forgetting the base case leads to infinite recursion and a stack overflow.

### Structural Recursion on Lists

The standard pattern for processing a list recursively:

```ocaml
let rec process lst =
  match lst with
  | []      -> (* base case: empty list *)
  | x :: xs -> (* recursive case: handle head x, recurse on tail xs *)
```

The list shrinks by one element each call, guaranteeing termination.

### The Accumulator Pattern (Tail Recursion)

Naïve recursion builds a large call stack. The **accumulator pattern** threads
an extra argument that accumulates the result, allowing the recursive call to
be in **tail position** (the last thing the function does):

```ocaml
let rec my_length_aux acc lst =
  match lst with
  | []      -> acc
  | _ :: xs -> my_length_aux (acc + 1) xs

let my_length lst = my_length_aux 0 lst
```

The OCaml compiler optimises tail-recursive calls into a loop, avoiding stack
overflow on large inputs.

### Mutual Recursion

Two functions can be mutually recursive using `let rec ... and ...`:

```ocaml
let rec is_even n = if n = 0 then true  else is_odd  (n - 1)
and     is_odd  n = if n = 0 then false else is_even (n - 1)
```

---

## Practice Assignments

### Assignment 1: factorial
Write `factorial : int -> int` that computes `n!` for `n >= 0`.
Recall: `0! = 1` and `n! = n * (n-1)!`.

### Assignment 2: fibonacci
Write `fibonacci : int -> int` that returns the nth Fibonacci number
(0-indexed: `fib 0 = 0`, `fib 1 = 1`, `fib n = fib (n-1) + fib (n-2)`).

### Assignment 3: my_length
Write `my_length : 'a list -> int` that counts the elements of a list using
recursion only — do not call `List.length`.

### Assignment 4: my_reverse
Write `my_reverse : 'a list -> 'a list` that reverses a list using recursion.
Hint: the accumulator pattern works well here.

### Assignment 5: my_map
Write `my_map : ('a -> 'b) -> 'a list -> 'b list` that applies a function to
every element of a list — do not call `List.map`.

### Assignment 6: count_down
Write `count_down : int -> int list` that, given `n >= 0`, returns the list
`[n; n-1; ...; 1; 0]`.

### Assignment 7: power
Write `power : int -> int -> int` where `power base exp` computes `base ^ exp`
for `exp >= 0` using only recursion. Recall `base^0 = 1`.
