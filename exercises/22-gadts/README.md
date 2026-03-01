# Exercise 22 — GADTs

## Theory

### What Are GADTs?

**Generalised Algebraic Data Types (GADTs)** extend ordinary ADTs by allowing each constructor to *refine* the return type index. The syntax uses `:` annotations:

```ocaml
type _ expr =
  | Lit_int  : int  -> int expr
  | Lit_bool : bool -> bool expr
  | Add      : int expr * int expr -> int expr
```

Each constructor's return type carries a concrete type in the index position. The type checker knows that pattern-matching `Lit_int _` implies the expression has type `int expr`, so the evaluator can return an `int` without any `option` or unsafe cast.

### The Type-Safe Evaluator

With GADTs, `eval` can have the type `type a. a expr -> a` — it returns exactly the type encoded in the expression. There is **no possibility of type confusion** at runtime. Without GADTs, a mixed expression language would require a sum type like `Val of int | VBool of bool` and runtime checks.

The key syntax for polymorphic recursion is:
```ocaml
let rec eval : type a. a expr -> a = function ...
```
The `type a.` introduces a *locally abstract type*, allowing the recursive calls to specialise `a` to different concrete types in each branch.

### Existential Types

When a GADT constructor has a type variable that appears in the *argument* but not the return type, it packages an **existential type**:

```ocaml
type _ hlist =
  | HNil  : unit hlist
  | HCons : 'a * 'b hlist -> ('a * 'b) hlist
```

The `'a` in `HCons` is existential when consumed — you can retrieve the head as its specific type, but the overall list type encodes the types of all elements structurally.

### Heterogeneous Lists (HLists)

An `hlist` stores elements of **different types** in a single list. The type index `('a * 'b)` is a type-level cons cell encoding the types of all elements. `hlength` uses a locally abstract type to recurse over the type index uniformly.

---

## Practice Assignments

### Assignment 1: eval int expressions
Implement `eval` for `Lit_int` and `Add`. Return the raw `int` or sum of recursive evaluations.

### Assignment 2: eval bool expressions
Implement `eval` for `Lit_bool` and `Eq`. The `Eq` constructor evaluates two int sub-expressions and compares them with `=`.

### Assignment 3: eval If expressions
The `If` constructor is polymorphic in `'a` — the then and else branches must have the same type, and the result is that type.

### Assignment 4: hhead and htail
Pattern-match `HCons` to extract the head and tail. The types encode which component you return.

### Assignment 5: hlength
Use `type a.` polymorphic recursion to traverse the `hlist` and count elements, returning a plain `int`.
