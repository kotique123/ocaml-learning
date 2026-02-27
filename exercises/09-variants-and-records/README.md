# Exercise 09 — Variants and Records

## Theory

OCaml's type system lets you define your own types. Two building blocks cover
almost everything: **sum types** (also called variants) and **product types**
(also called records or tuples).

### Sum Types (Variants)

A variant type enumerates a fixed set of **cases**, each optionally carrying
data:

```ocaml
type colour = Red | Green | Blue
type option_int = None | Some of int
type expr =
  | Num   of int
  | Plus  of expr * expr
  | Times of expr * expr
```

Each constructor (e.g. `Red`, `Some`, `Plus`) is a data-constructor that builds
a value of the type. Variants are the correct tool whenever a value can be *one
of several different things*.

### Product Types (Records)

A record groups several **named fields** together:

```ocaml
type point = { x : float; y : float }
let origin = { x = 0.0; y = 0.0 }
let px = origin.x       (* field access with dot notation *)
```

Records are immutable by default. To create a modified copy use the
**functional update syntax**:

```ocaml
let moved = { origin with x = 3.0 }   (* y stays 0.0 *)
```

### Pattern Matching

Pattern matching works uniformly on both variants and records:

```ocaml
match colour with
| Red   -> "red"
| Green -> "green"
| Blue  -> "blue"

match point with
| { x = 0.0; y = 0.0 } -> "origin"
| { x; y }             -> Printf.sprintf "(%f, %f)" x y
```

The compiler warns you if you miss a constructor, making exhaustiveness checking
a powerful safety net.

### Recursive Types

Variants can be self-referential, enabling trees and other recursive structures:

```ocaml
type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree
```

---

## Practice Assignments

### Assignment 1: opposite
Write `opposite : direction -> direction` that returns the cardinal direction
directly opposite (North ↔ South, East ↔ West).

### Assignment 2: is_horizontal
Write `is_horizontal : direction -> bool` that returns `true` exactly when the
direction is East or West.

### Assignment 3: area
Write `area : shape -> float` that computes the area of a `Circle`, `Rectangle`,
or `Triangle`. Use `Float.pi` for circles and Heron's formula for triangles.

### Assignment 4: perimeter
Write `perimeter : shape -> float` that computes the perimeter of each shape.
For a circle, the perimeter (circumference) is `2 * pi * r`.

### Assignment 5: make_person
Write `make_person : string -> int -> string -> person` that constructs a
`person` record from name, age, and email.

### Assignment 6: is_adult
Write `is_adult : person -> bool` that returns `true` if the person's age is
18 or over.

### Assignment 7: birthday
Write `birthday : person -> person` that returns a **new** person record with
the age field incremented by 1. Use the functional update syntax `{ p with ... }`.
The original record must not be changed.
