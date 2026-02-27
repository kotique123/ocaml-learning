# Copilot Instructions — OCaml Learning Curriculum

## Curriculum Overview

This repository is a structured OCaml learning curriculum with 30 exercises in `exercises/NN-slug/`. Each exercise is a standalone Dune project. **The learner's only job is to edit `lib/exercise.ml`** — replacing `failwith "not implemented"` stubs with working implementations until `dune test` passes.

## Exercise Structure

```
exercises/NN-slug/
├── README.md             # Theory block + numbered practice assignments
├── dune-project          # (lang dune 3.16) — do not change
├── lib/
│   ├── dune              # (library (name exercise) (modules exercise))
│   └── exercise.ml       # Skeleton — learner fills in failwith "not implemented" stubs
└── test/
    ├── dune              # (test (name exercise_spec) (libraries exercise alcotest))
    └── exercise_spec.ml  # Pre-written Alcotest tests — DO NOT MODIFY
```

## Critical Rules

- **Never modify `test/exercise_spec.ml`** — tests are the ground truth
- **Never change `(lang dune 3.16)` in `dune-project`** — all exercises use OCaml 5.2
- Stubs use `failwith "not implemented"` — never omit a function (it must typecheck against the test)
- `lib/exercise.ml` must expose every symbol imported by `exercise_spec.ml`
- Alcotest `test_case` strings must exactly match assignment names in README.md
- README theory blocks may reference concepts from prior exercises only

## Build & Test

```bash
# Enter an exercise and run its tests
cd exercises/01-hello-ocaml
dune test

# Run a single test group by name (Alcotest filter)
dune test --no-buffer 2>&1 | grep -A5 "Assignment 1"

# Open a REPL for the exercise
dune utop lib

# Format source
ocamlformat --inplace lib/exercise.ml

# Run all exercises
for dir in exercises/*/; do (cd "$dir" && dune test --no-buffer); done
```

## Creating a New Exercise

1. `dune-project`: `(lang dune 3.16)` only
2. `lib/dune`: `(library (name exercise) (modules exercise))`
3. `test/dune`: `(test (name exercise_spec) (libraries exercise alcotest))`
4. `lib/exercise.ml`: explicit type signatures + `= failwith "not implemented"` bodies
5. `test/exercise_spec.ml`: `Alcotest.run "Exercise NN"` with `("Assignment N: <name>", [test_case …])` groups; must compile against the skeleton
6. `README.md`: theory first (200–600 words, code examples showing concepts not answers), then `## Practice Assignments` with numbered sections **exactly matching** the Alcotest group strings

## Key OCaml Conventions

- Stubs: `let f (x : t) : r = failwith "not implemented"` — always include full type annotation
- Prefer explicit module opens via `let open M in` or qualified `M.f` over `open M` at top level
- Use `Result` for recoverable errors, `Option` for optional values, exceptions only for truly unexpected failures
- `Map.Make` and `Set.Make` are the standard functor-based containers
- OCaml 5 features (domains, effects) require OCaml >= 5.0 — all exercises target OCaml 5.2
- Prefer `List.fold_left` over `List.fold_right` for tail-recursion
- Use `Printf.printf` / `Printf.sprintf` for formatted output, not string concatenation
- `.ocamlformat` at repo root sets `version = 0.26.2, profile = default` — apply to all files
