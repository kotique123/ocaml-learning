# Exercise 21 — Polymorphism

## Theory

### Parametric Polymorphism

OCaml supports **parametric polymorphism** through type variables written `'a`, `'b`, etc. A function like `List.length : 'a list -> int` works for lists of *any* element type. The type variable `'a` is universally quantified — callers choose the concrete type at each use site. This is sometimes called *generics* in other languages, but in OCaml it is inferred automatically without any annotations.

### Phantom Types

A **phantom type** is a type parameter that appears in the type but not in the runtime representation. It exists purely to encode invariants that the type-checker can verify at compile time, with **zero runtime cost**.

```ocaml
type empty   = Empty
type nonempty = Nonempty

type (_, 'a) typed_stack =
  | Empty_stack : (empty, 'a) typed_stack
  | Push : 'a * (_, 'a) typed_stack -> (nonempty, 'a) typed_stack
```

The first type parameter is a phantom: `empty` or `nonempty` is encoded in the type, so calling `top` on an empty stack is a **compile-time error**, not a runtime exception. There is no tag stored in memory — only the type checker cares.

### Length-Indexed Vectors (Dependent-Style in OCaml)

We can encode the *length* of a list in its type using Peano numerals:

```ocaml
type zero    = Zero
type 'n succ = Succ of 'n

type (_, 'a) vec =
  | VNil  : (zero, 'a) vec
  | VCons : 'a * ('n, 'a) vec -> ('n succ, 'a) vec
```

A `(zero succ succ, int) vec` is exactly a two-element `int` vector. `vhead` accepts only `('n succ, 'a) vec`, so it is statically safe.

### Value Restriction

OCaml's **value restriction** prevents unsound generalisation of mutable references. A `let` binding is only given a polymorphic type when its right-hand side is a *syntactic value* (a function, constructor, etc.). This avoids runtime type errors at the cost of sometimes requiring explicit type annotations or eta-expansion.

---

## Practice Assignments

### Assignment 1: push and top
Implement `push` and `top` for `typed_stack`. `push x s` wraps the element in a `Push` constructor. `top` pattern-matches a non-empty stack and returns the head element.

### Assignment 2: pop
Implement `pop` to return both the top element and the remainder of the stack. Notice the return type `'a * (_, 'a) typed_stack` — the remainder may be empty or non-empty.

### Assignment 3: vhead and vtail
Implement `vhead` and `vtail` for `vec`. Both are total by construction — the type guarantees a non-empty vector is supplied.

### Assignment 4: vec_to_list
Implement `vec_to_list` using a locally abstract type annotation `type n.` to allow the recursive call to handle the changing length index.
