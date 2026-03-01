# Exercise 18 — Advanced Modules

## Theory

OCaml's module system is one of the most powerful in any mainstream language. Beyond simple namespacing, it supports **functors** (parameterized modules) and **first-class modules** (modules as values).

### Functors — parameterized modules

A functor is a module-level function: it takes a module as input and produces a module as output.

```ocaml
module type COMPARABLE = sig
  type t
  val compare : t -> t -> int
end

module PriorityQueue (C : COMPARABLE) = struct
  type t = C.t list
  let insert x q = List.sort C.compare (x :: q)
end
```

You instantiate a functor with a concrete module:

```ocaml
module IntPQ = PriorityQueue(Int)
module StringPQ = PriorityQueue(String)
```

### Functors vs Haskell typeclasses

Haskell typeclasses (`Ord`, `Eq`) achieve similar goals but are resolved **implicitly** by the compiler. OCaml functors are **explicit**: you pass the implementation module yourself. This makes code more verbose but also more predictable — there is no implicit instance resolution, and you can have multiple instances for the same type.

### Module type `with`

You can refine abstract types in module signatures:

```ocaml
module type S = sig type t end
module M : S with type t = int = struct type t = int end
```

### First-class modules

Modules can be packed into values and unpacked later:

```ocaml
let m = (module Int : COMPARABLE) 
let module M = (val m : COMPARABLE) in M.compare 1 2
```

This enables storing different module implementations in lists, passing them to functions, and building plugin-style architectures.

### `include`

`include M` copies all definitions from module `M` into the current scope — useful for extending existing modules without repetition.

---

## Practice Assignments

### Assignment 1: PriorityQueue
Implement `insert`, `pop_min`, and `size` for the sorted-list-backed priority queue functor. `insert` should maintain sorted order; `pop_min` should return the smallest element and the remaining queue.

### Assignment 2: RingBuffer
Implement `make`, `push`, `to_list`, `size`, and `capacity` for the fixed-size circular buffer. When the buffer is full, `push` should drop the oldest element.
