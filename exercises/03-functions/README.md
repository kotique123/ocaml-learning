# Exercise 03 — Functions

## Theory

### Let definitions
Functions in OCaml are values. A named function is just a `let` binding whose right-hand side is a function:
```ocaml
let square x = x * x
let square = fun x -> x * x   (* identical *)
```
Both forms produce the same result. The `fun x ->` syntax creates an **anonymous function** (also called a lambda).

### Currying
Every OCaml function takes **exactly one argument** and returns a value. A "two-argument" function is actually a function that takes one argument and returns another function:
```ocaml
let add x y = x + y
(* has type: int -> int -> int
   which is:  int -> (int -> int) *)
```
This representation is called **currying** (after logician Haskell Curry).

### Partial application
Because of currying, you can supply fewer arguments than a function expects and get a new function back:
```ocaml
let add5 = add 5        (* type: int -> int *)
let ten  = add5 5       (* 10 *)
```
Partial application is a lightweight way to create specialised functions without writing a new `let` definition.

### The pipe operator `|>`
`|>` threads a value through a series of function calls, left to right:
```ocaml
let result = 3 |> add 1 |> ( * ) 2   (* (3 + 1) * 2 = 8 *)
```
It improves readability when several transformations are applied in sequence by mirroring the order of execution.

### The application operator `@@`
`@@` is the low-precedence function application operator. `f @@ g x` means `f (g x)`. It is useful to avoid deeply nested parentheses:
```ocaml
print_endline @@ string_of_int @@ 1 + 2
```

### Higher-order functions
A **higher-order function** takes other functions as arguments or returns them. `apply`, `compose`, `flip`, and `twice` are classic examples. They are the building blocks of functional programming style and are used extensively in the OCaml standard library (`List.map`, `List.filter`, etc.).

### Labeled arguments
OCaml supports labeled arguments with `~label:` syntax, making call sites self-documenting and allowing arguments to be supplied in any order. They are introduced here as a preview; you will see them more in later exercises.

---

## Practice Assignments

### Assignment 1: apply
Implement `apply f x` to apply function `f` to argument `x`.

### Assignment 2: compose
Implement `compose f g x` to apply `g` first, then `f` to the result — mathematical function composition (f ∘ g)(x).

### Assignment 3: flip
Implement `flip f x y` to call `f` with its first two arguments swapped.

### Assignment 4: add (partial application)
Implement `add x y` returning `x + y`. Then observe how `add 5` creates a new `int -> int` function via partial application.

### Assignment 5: pipeline
Implement `pipeline x fns` to apply each function in the list `fns` to `x` in order, passing the result of each step to the next.

### Assignment 6: twice
Implement `twice f x` to apply `f` to `x`, then apply `f` again to the result.
