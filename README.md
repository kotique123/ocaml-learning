# Learn OCaml — From Zero to Advanced

A structured, hands-on OCaml curriculum with 30 progressive exercises. Each exercise is a self-contained Dune project containing:

- **README.md** — theory explanation + numbered practice assignments
- **`lib/exercise.ml`** — skeleton with `failwith "not implemented"` stubs for you to fill in
- **`test/exercise_spec.ml`** — pre-written Alcotest tests (do not modify these)

## Quick Start

Prerequisites: [opam](https://opam.ocaml.org/) with OCaml 5.2 and dune

```bash
# Install test dependency (once)
opam install alcotest

# Enter an exercise
cd exercises/01-hello-ocaml

# Run the tests (they will all fail until you implement the stubs)
dune test

# Open a REPL for the exercise
dune utop lib
```

Your job for each exercise: read `README.md`, then edit `lib/exercise.ml` to replace `failwith "not implemented"` stubs with working implementations until all tests pass.

---

## Curriculum

### Part 1 — Foundations

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 01 | [hello-ocaml](exercises/01-hello-ocaml) | utop, `print_endline`, `Printf.printf`, `let`, string `^` |
| 02 | [types-and-values](exercises/02-types-and-values) | `int`, `float`, `bool`, `char`, `string`, type annotations, conversion fns |
| 03 | [functions](exercises/03-functions) | `let f x =`, `fun x ->`, partial application, `\|>`, `@@` |
| 04 | [pattern-matching](exercises/04-pattern-matching) | `match … with`, tuple patterns, wildcards, exhaustiveness |
| 05 | [conditionals](exercises/05-conditionals) | `if/then/else`, `match` guards (`when`), nested conditions |
| 06 | [lists](exercises/06-lists) | `[]`, `::`, `List.map/filter/fold_left/fold_right/length/rev` |
| 07 | [recursion](exercises/07-recursion) | base/recursive cases, structural recursion, accumulator pattern |
| 08 | [higher-order-functions](exercises/08-higher-order-functions) | `List.map/filter/fold_left`, function composition, `Fun.compose` |
| 09 | [variants-and-records](exercises/09-variants-and-records) | `type t = A \| B of …`, record types, pattern matching on both |
| 10 | [modules-and-signatures](exercises/10-modules-and-signatures) | `module M = struct … end`, `module type S = sig … end`, dot notation |

### Part 2 — Core Abstractions

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 11 | [option-and-result](exercises/11-option-and-result) | `option`, `result`, `Option.map/bind/value`, `Result.map/bind` |
| 12 | [map-and-set](exercises/12-map-and-set) | `Map.Make`, `Set.Make` (functors), `Map.S`/`Set.S` interfaces |
| 13 | [sequences-and-arrays](exercises/13-sequences-and-arrays) | `Array`, `Seq` (lazy), `Array.map/fold`, `Seq.map/filter/take` |
| 14 | [strings-and-buffers](exercises/14-strings-and-buffers) | `String` module, `Buffer`, `Bytes`, `String.split_on_char`, `Printf.sprintf` |
| 15 | [io-and-refs](exercises/15-io-and-refs) | `print_string`, `read_line`, file IO, `ref`/`!`/`:=` |

### Part 3 — Intermediate

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 16 | [exceptions](exercises/16-exceptions) | `exception E of t`, `raise`, `try … with`, `Result` vs exceptions |
| 17 | [mutable-state](exercises/17-mutable-state) | `ref`, `Array`, `Hashtbl`, `Queue`, `Stack` |
| 18 | [advanced-modules](exercises/18-advanced-modules) | parameterized modules (functors), first-class modules, `(module M : S)` |
| 19 | [data-structures](exercises/19-data-structures) | `Map`, `Set`, `Queue`, `Stack`, `Hashtbl` — pick-the-right-structure problems |
| 20 | [tail-recursion](exercises/20-tail-recursion) | tail-call pattern, CPS transform, `List.rev_append`, `fold_left` vs naive |

### Part 4 — Advanced

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 21 | [polymorphism](exercises/21-polymorphism) | parametric polymorphism `'a`, phantom types, abstract types via signature |
| 22 | [gadts](exercises/22-gadts) | GADT `type _ t = …`, existential types, type-safe heterogeneous structures |
| 23 | [ppx-and-deriving](exercises/23-ppx-and-deriving) | `ppx_deriving.show/eq/ord`, `[@@deriving show, eq]`, attribute syntax |
| 24 | [domains-and-concurrency](exercises/24-domains-and-concurrency) | `Domain.spawn`, `Mutex`, `Semaphore`, `Atomic`, OCaml 5 parallelism |
| 25 | [algebraic-effects](exercises/25-algebraic-effects) | `Effect.perform`, `Effect.Deep.match_with`, handler patterns (OCaml 5) |

### Part 5 — Mastery

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 26 | [format-and-pp](exercises/26-format-and-pp) | `Format`, `pp_print_*`, `%a` format spec, structured pretty printing |
| 27 | [lazy-and-memoization](exercises/27-lazy-and-memoization) | `lazy`, `Lazy.force`, memoization with `Hashtbl`, lazy streams |
| 28 | [parsing](exercises/28-parsing) | Angstrom: `let*`, `return`, `string`, `char`, `many`, `choice` |
| 29 | [c-interop](exercises/29-c-interop) | `external` declarations, C stubs, `Bigarray`, `Ctypes` basics |
| 30 | [profiling-optimization](exercises/30-profiling-optimization) | `landmarks`, `core_bench`, strictness, boxing, allocation avoidance |

---

## Running All Tests

```bash
# Run every exercise's test suite
for dir in exercises/*/; do (cd "$dir" && dune test); done
```
