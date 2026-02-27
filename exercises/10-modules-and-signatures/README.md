# Exercise 10 — Modules and Signatures

## Theory

Modules are OCaml's primary unit of code organisation. Every `.ml` file is
automatically a module, but you can also define modules inline.

### Module Syntax

```ocaml
module Greet = struct
  let hello name = "Hello, " ^ name ^ "!"
end

let msg = Greet.hello "world"
```

Use **dot notation** (`Module.value`) to access definitions inside a module.
You can bring names into scope with `open Module` (use sparingly).

### Module Types (Signatures)

A **signature** describes the interface of a module — what it exports — without
revealing how it is implemented:

```ocaml
module type GREET = sig
  val hello : string -> string
end
```

You attach a signature to an implementation with a colon:

```ocaml
module Greet : GREET = struct
  let hello name = "Hello, " ^ name ^ "!"
end
```

Only names listed in the signature are visible outside the module.

### Abstract Types

When a type appears in the signature *without* its definition, it becomes
**abstract** — callers cannot inspect or construct values of that type except
through the functions provided:

```ocaml
module type COUNTER = sig
  type t
  val make      : int -> t
  val increment : t -> t
  val value     : t -> int
end
```

The representation (`type t = int`, `type t = { ... }`, etc.) is hidden inside
the implementation. This is **encapsulation**: implementation details can change
without breaking any code that uses the module.

### `include`

`include M` copies all definitions from module `M` into the current module,
which is useful for extending or combining modules.

### First-Class Modules (Preview)

Modules can be packed into values and passed to functions using `(module M)`
syntax and `(module type of ...)`, enabling highly generic programming. This is
an advanced topic you will explore later.

---

## Practice Assignments

### Assignment 1: Stack
Complete the `Stack` module. A stack is a **LIFO** (last-in, first-out)
structure. Implement `push` (add to top), `pop` (remove from top, returning
`None` on an empty stack), `is_empty`, and `size`. The representation `'a list`
is already chosen for you — the front of the list is the top of the stack.

### Assignment 2: Queue
Complete the `Queue` module. A queue is a **FIFO** (first-in, first-out)
structure. Implement `enqueue` (add to back), `dequeue` (remove from front,
returning `None` on empty), `is_empty`, and `size`. The two-list representation
(`front` and `rear`) amortises the cost of `dequeue` to O(1): add to `rear`,
and when `front` is empty move the reversed `rear` to `front`.

### Assignment 3: Counter
Complete the `Counter` module with an abstract type `t`. Implement `make`
(create a counter with an initial value), `increment`, `decrement`, `value`
(read the current count), and `reset` (return the counter to its initial value).
Because `t` is abstract, users can only interact with a counter through these
five functions.
