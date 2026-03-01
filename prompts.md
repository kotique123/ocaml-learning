# Fix Prompts for OCaml Learning Curriculum

Each prompt below is self-contained and can be given to Sonnet independently.
Run them in order — some later prompts depend on earlier ones being completed.

---

## Prompt 1: Fix skeleton compilation — suppress warning 27 in all lib/dune files

```
In this OCaml learning curriculum, all exercise skeletons use `failwith "not implemented"` stubs
with named parameters, which triggers `warning 27 [unused-var-strict]` and prevents `dune build`
from succeeding. Fix this by adding warning suppression flags to every `lib/dune` file across
all 30 exercises.

Rules:
- Every `exercises/NN-*/lib/dune` must include `(ocamlopt_flags (:standard -w -27))` and
  `(ocamlc_flags (:standard -w -27))`
- Some exercises already have warning flags — MERGE them, don't duplicate:
  - exercises/07-recursion/lib/dune already has `-w -39` → change to `-w -27-39`
  - exercises/08-higher-order-functions/lib/dune already has `-w -39` → change to `-w -27-39`
  - exercises/10-modules-and-signatures/lib/dune already has `-w -69` → change to `-w -27-69`
- All other exercises currently have no flags — add the two flag lines
- Exercise 23-ppx-and-deriving has `(preprocess ...)` — keep that, add the flags too
- Exercise 28-parsing has `(libraries angstrom)` — keep that, add the flags too
- Do NOT modify test/dune, dune-project, or any .ml files

Example of what a basic lib/dune should look like after the fix:
(library
 (name exercise)
 (modules exercise)
 (ocamlopt_flags (:standard -w -27))
 (ocamlc_flags (:standard -w -27)))

Example for exercise 07 after merging:
(library
 (name exercise)
 (modules exercise)
 (ocamlopt_flags (:standard -w -27-39))
 (ocamlc_flags (:standard -w -27-39)))

After making changes, verify by running: cd exercises/02-types-and-values && dune build
```

---

## Prompt 2: Convert exercise 01 from solved to stub skeleton

```
Exercise 01 (exercises/01-hello-ocaml) currently has complete implementations in lib/exercise.ml
instead of `failwith "not implemented"` stubs. The learner has nothing to do.

1. First, copy the current lib/exercise.ml to lib/solution.ml (preserving it as the reference solution)
2. Then replace lib/exercise.ml with a stub skeleton

The stub skeleton must:
- Keep all doc-comments (lines starting with `(**`)
- Keep all type signatures exactly as they are
- Replace function BODIES with `failwith "not implemented"`
- Fix the `bmi` boundary: the doc-comment says `< 25.0` for Normal threshold, which is correct

Here is what lib/exercise.ml should become:

(** [greet name] returns ["Hello, " ^ name ^ "!"] *)
let greet (name : string) : string = failwith "not implemented"

(** [double n] returns [n * 2] *)
let double (n : int) : int = failwith "not implemented"

(** [circle_area r] returns the area of a circle with radius [r]. Use Float.pi. *)
let circle_area (r : float) : float = failwith "not implemented"

(** [bmi weight height] returns "Underweight", "Normal", or "Overweight".
    BMI = weight /. (height *. height). Thresholds: <18.5 Under, <25.0 Normal, else Over. *)
let bmi (weight : float) (height : float) : string = failwith "not implemented"

And fix the boundary bug in lib/solution.ml — change `bmi_value <= 25.0` to `bmi_value < 25.0`
so it matches the README spec (Normal is 18.5 ≤ BMI < 25.0).

After making changes, verify: cd exercises/01-hello-ocaml && dune build
```

---

## Prompt 3: Convert exercises 21-25 from solved to stub skeletons

```
Exercises 21-25 currently have complete implementations in lib/exercise.ml instead of
`failwith "not implemented"` stubs. For each exercise, create lib/solution.ml from the
current implementation, then replace lib/exercise.ml with stubs.

IMPORTANT RULES:
- Keep ALL type definitions, module types, effect declarations, and `open` statements intact
- Keep ALL doc-comments
- Only replace function/value BODIES with `failwith "not implemented"`
- For functions using GADTs/polymorphic recursion, keep the type annotation on the stub
- Exercise 25 solution.ml: rename unused `k` to `_k` on line 58 to fix warning 27

Here are the exact stubs needed for each exercise:

### exercises/21-polymorphism/lib/exercise.ml
Keep: type definitions for empty, nonempty, typed_stack, packed_stack, zero, succ, vec
Stub these functions:
  let push (x : 'a) (s : (_, 'a) typed_stack) : (nonempty, 'a) typed_stack = failwith "not implemented"
  let top (s : (nonempty, 'a) typed_stack) : 'a = failwith "not implemented"
  let pop (s : (nonempty, 'a) typed_stack) : 'a * 'a packed_stack = failwith "not implemented"
  let vhead (v : ('n succ, 'a) vec) : 'a = failwith "not implemented"
  let vtail (v : ('n succ, 'a) vec) : ('n, 'a) vec = failwith "not implemented"
  let rec vec_to_list : type n. (n, 'a) vec -> 'a list = failwith "not implemented"

### exercises/22-gadts/lib/exercise.ml
Keep: type definitions for expr, hlist
Stub these functions:
  let rec eval : type a. a expr -> a = failwith "not implemented"
  let hhead (lst : ('a * 'b) hlist) : 'a = failwith "not implemented"
  let htail (lst : ('a * 'b) hlist) : 'b hlist = failwith "not implemented"
  let rec hlength : type a. a hlist -> int = failwith "not implemented"

### exercises/23-ppx-and-deriving/lib/exercise.ml
Keep: type definitions for color, point, tree WITH their [@@deriving] attributes
Stub these functions:
  let color_to_hex (c : color) : string = failwith "not implemented"
  let distance (p1 : point) (p2 : point) : float = failwith "not implemented"
  let rec tree_depth (t : 'a tree) : int = failwith "not implemented"
  let rec tree_insert (x : 'a) (t : 'a tree) : 'a tree = failwith "not implemented"

### exercises/24-domains-and-concurrency/lib/exercise.ml
Stub these functions:
  let parallel_map (f : 'a -> 'b) (lst : 'a list) : 'b list = failwith "not implemented"
  let parallel_sum (lst : int list) : int = failwith "not implemented"
  let thread_safe_counter () : (unit -> unit) * (unit -> int) = failwith "not implemented"
  let atomic_counter () : (unit -> unit) * (unit -> int) = failwith "not implemented"

### exercises/25-algebraic-effects/lib/exercise.ml
Keep: `open Effect.Deep` and ALL effect type declarations (Log, Get, Put, Abort)
Stub these functions:
  let run_with_log (f : unit -> 'a) : 'a * string list = failwith "not implemented"
  let run_state (initial : int) (f : unit -> 'a) : 'a * int = failwith "not implemented"
  let run_with_abort (f : unit -> 'a) (default : 'a) : 'a = failwith "not implemented"

In the solution.ml files, fix exercise 25 line 58: change `(k : (a, _) continuation)` to
`(_k : (a, _) continuation)` to suppress the unused variable warning.

After making changes, verify each builds: for dir in exercises/2{1,2,3,4,5}-*/; do (cd "$dir" && dune build && echo "OK: $(basename $dir)"); done
```

---

## Prompt 4: Standardize Alcotest.run title format across all exercises

```
The `Alcotest.run` title strings in test/exercise_spec.ml are inconsistent across exercises.
Standardize them ALL to the format: "Exercise NN — Title Case Name"
(using em-dash — U+2014, with Title Case after it).

DO NOT modify anything else in the test files — only the single string passed to Alcotest.run / run.

Here are the exact changes needed (showing old → new):

exercises/06-lists/test/exercise_spec.ml:
  "Exercise 06 — lists"  →  "Exercise 06 — Lists"

exercises/07-recursion/test/exercise_spec.ml:
  "Exercise 07 — recursion"  →  "Exercise 07 — Recursion"

exercises/08-higher-order-functions/test/exercise_spec.ml:
  "Exercise 08 — higher-order-functions"  →  "Exercise 08 — Higher-Order Functions"

exercises/09-variants-and-records/test/exercise_spec.ml:
  "Exercise 09 — variants-and-records"  →  "Exercise 09 — Variants and Records"

exercises/10-modules-and-signatures/test/exercise_spec.ml:
  "Exercise 10 — modules-and-signatures"  →  "Exercise 10 — Modules and Signatures"

exercises/11-option-and-result/test/exercise_spec.ml:
  "Exercise 11 — option-and-result"  →  "Exercise 11 — Option and Result"

exercises/12-map-and-set/test/exercise_spec.ml:
  "Exercise 12 — map-and-set"  →  "Exercise 12 — Map and Set"

exercises/13-sequences-and-arrays/test/exercise_spec.ml:
  "Exercise 13 — sequences-and-arrays"  →  "Exercise 13 — Sequences and Arrays"

exercises/14-strings-and-buffers/test/exercise_spec.ml:
  "Exercise 14 — strings-and-buffers"  →  "Exercise 14 — Strings and Buffers"

exercises/15-io-and-refs/test/exercise_spec.ml:
  "Exercise 15 — io-and-refs"  →  "Exercise 15 — IO and Refs"

exercises/21-polymorphism/test/exercise_spec.ml:
  "Polymorphism"  →  "Exercise 21 — Polymorphism"

exercises/22-gadts/test/exercise_spec.ml:
  "GADTs"  →  "Exercise 22 — GADTs"

exercises/23-ppx-and-deriving/test/exercise_spec.ml:
  "PPX and Deriving"  →  "Exercise 23 — PPX and Deriving"

exercises/24-domains-and-concurrency/test/exercise_spec.ml:
  "Domains and Concurrency"  →  "Exercise 24 — Domains and Concurrency"

exercises/25-algebraic-effects/test/exercise_spec.ml:
  "Algebraic Effects"  →  "Exercise 25 — Algebraic Effects"

exercises/26-format-and-pp/test/exercise_spec.ml:
  "Exercise 26: format-and-pp"  →  "Exercise 26 — Format and PP"

exercises/27-lazy-and-memoization/test/exercise_spec.ml:
  "Exercise 27: lazy-and-memoization"  →  "Exercise 27 — Lazy and Memoization"

exercises/28-parsing/test/exercise_spec.ml:
  "Exercise 28: parsing"  →  "Exercise 28 — Parsing"

exercises/29-c-interop/test/exercise_spec.ml:
  "Exercise 29: c-interop"  →  "Exercise 29 — C Interop"

exercises/30-profiling-optimization/test/exercise_spec.ml:
  "Exercise 30: profiling-optimization"  →  "Exercise 30 — Profiling and Optimization"

These are already correct and should NOT be changed:
  exercises/01 through 05, 16 through 20

For exercises 21-25: these files use `open Alcotest` and then bare `run "..."`. When changing
the title, keep using bare `run` — do NOT add `Alcotest.` prefix. Just change the string.

Verify after changes: for dir in exercises/*/; do grep -o 'run "[^"]*"' "$dir/test/exercise_spec.ml" | grep -v 'Exercise\.run' | head -1; done
```

---

## Prompt 5: Standardize README assignment heading format across all exercises

```
The README.md assignment headings use different formats across exercises. Standardize ALL of them
to match this format: `### Assignment N: name`

This means the README heading text (after "### ") must EXACTLY match the Alcotest test group string.
For example, if the test has `"Assignment 1: safe_div"`, the README must have `### Assignment 1: safe_div`.

Here are the exercises that need changes (exercises 01-10 already use the correct format):

### Exercises 11-15 (currently: numbered list with bold)
Change from: `1. **Assignment N: name** — description text`
Change to: `### Assignment N: name` on its own line, with the description as a paragraph below.

### Exercises 16-25 (currently: bold paragraph with em-dash)
Change from: `**Assignment N — \`name\`:** description text`
Change to: `### Assignment N: name` on its own line, with the description as a paragraph below.

For exercises 16-25, note the name mapping (the test uses `: ` not ` — `):
- Test: "Assignment 1: safe_div" → README: ### Assignment 1: safe_div
- Test: "Assignment 1: PriorityQueue" → README: ### Assignment 1: PriorityQueue
- Test: "Assignment 1: push and top" → README: ### Assignment 1: push and top

### Exercises 26-30 (currently: heading with em-dash and backticks)
Change from: `### Assignment N — \`name\``
Change to: `### Assignment N: name` (colon, no backticks)

For these, the description text on lines below the heading should be preserved as-is.

IMPORTANT: The heading text after `### ` must EXACTLY match what's in the test file between quotes.
Double-check each one against the test group strings:

Ex 11: "Assignment 1: safe_div", "Assignment 2: safe_sqrt", "Assignment 3: option_map", "Assignment 4: option_bind", "Assignment 5: parse_int", "Assignment 6: result_map", "Assignment 7: chain_divs"
Ex 12: "Assignment 1: word_count", "Assignment 2: most_frequent", "Assignment 3: unique_ints", "Assignment 4: intersection_count", "Assignment 5: invert_map"
Ex 13: "Assignment 1: array_sum", "Assignment 2: array_rotate", "Assignment 3: running_total", "Assignment 4: naturals", "Assignment 5: seq_take", "Assignment 6: seq_squares"
Ex 14: "Assignment 1: palindrome", "Assignment 2: word_wrap", "Assignment 3: count_vowels", "Assignment 4: title_case", "Assignment 5: repeat_string", "Assignment 6: csv_row"
Ex 15: "Assignment 1: make_counter", "Assignment 2: memoize", "Assignment 3: read_lines / write_lines", "Assignment 4: running_average"
Ex 16: "Assignment 1: safe_div", "Assignment 2: safe_nth", "Assignment 3: try_div", "Assignment 4: with_default", "Assignment 5: validate_age"
Ex 17: "Assignment 1: swap", "Assignment 2: array_fill_range", "Assignment 3: histogram", "Assignment 4: dedup_array", "Assignment 5: queue_rotate"
Ex 18: "Assignment 1: PriorityQueue", "Assignment 2: RingBuffer"
Ex 19: "Assignment 1: frequency_map", "Assignment 2: top_n", "Assignment 3: bst_insert and bst_mem", "Assignment 4: bst_to_sorted_list", "Assignment 5: anagram_groups"
Ex 20: "Assignment 1: sum_naive", "Assignment 2: sum_tr", "Assignment 3: reverse_tr", "Assignment 4: flatten_tr", "Assignment 5: map_tr", "Assignment 6: fibonacci_tr", "Assignment 7: range"
Ex 21: "Assignment 1: push and top", "Assignment 2: pop", "Assignment 3: vhead and vtail", "Assignment 4: vec_to_list"
Ex 22: "Assignment 1: eval int expressions", "Assignment 2: eval bool expressions", "Assignment 3: eval If expressions", "Assignment 4: hhead and htail", "Assignment 5: hlength"
Ex 23: "Assignment 1: color_to_hex", "Assignment 2: color show and eq", "Assignment 3: distance", "Assignment 4: tree_depth", "Assignment 5: tree_insert"
Ex 24: "Assignment 1: parallel_map", "Assignment 2: parallel_sum", "Assignment 3: thread_safe_counter", "Assignment 4: atomic_counter"
Ex 25: "Assignment 1: run_with_log", "Assignment 2: run_state", "Assignment 3: run_with_abort"
Ex 26: "Assignment 1: pp_list", "Assignment 2: pp_tree", "Assignment 3: pp_record", "Assignment 4: format_table"
Ex 27: "Assignment 1: force_once", "Assignment 2: memoize", "Assignment 3: fib_memo", "Assignment 4: lazy_range", "Assignment 5: lazy_filter", "Assignment 6: lazy_fibs"
Ex 28: "Assignment 1: parse_int", "Assignment 2: parse_csv_line", "Assignment 3: parse_json_bool", "Assignment 4: parse_list_of_ints"
Ex 29: "Assignment 1: create_buffer", "Assignment 2: buffer_fill", "Assignment 3: buffer_sum", "Assignment 4: buffer_to_string and bytes_to_buffer", "Assignment 5: xor_buffers"
Ex 30: "Assignment 1: time_it", "Assignment 2: sum_list_naive", "Assignment 3: sum_list_fast", "Assignment 4: sum_array", "Assignment 5: float_array_dot", "Assignment 6: sieve_of_eratosthenes", "Assignment 7: merge_sort"

Do NOT change the description text content — only reformat the heading structure.
Do NOT change the ## Practice Assignments section header.
Do NOT change the theory section above ## Practice Assignments.
```

---

## Prompt 6: Standardize test file coding style (qualified Alcotest usage)

```
Exercises 21-30 use `open Alcotest` at the top of test/exercise_spec.ml and then call
bare `run`, `test_case`, `check`, etc. Exercises 01-20 use qualified calls like `Alcotest.run`,
`Alcotest.test_case`, `Alcotest.(check string)`.

Standardize exercises 21-30 to match exercises 01-20's style:
- Remove `open Alcotest` (or `let open Alcotest in`)
- Replace bare `run` with `Alcotest.run`
- Replace bare `test_case` with `Alcotest.test_case`
- Replace bare `check` with `Alcotest.(check ...)`  or  `Alcotest.check`
- Replace bare testable names (`int`, `string`, `bool`, `list`, `float`, `pair`) with
  `Alcotest.int`, `Alcotest.string`, etc. — or use `Alcotest.(check (list int))` form

ALSO standardize module access — exercises 09, 10, 21-25 use `open Exercise`. Remove
`open Exercise` and use qualified `Exercise.function_name` calls instead.

Affected files:
- exercises/09-variants-and-records/test/exercise_spec.ml (only `open Exercise` → qualified)
- exercises/10-modules-and-signatures/test/exercise_spec.ml (only `open Exercise` → qualified)
- exercises/21-polymorphism/test/exercise_spec.ml (both opens)
- exercises/22-gadts/test/exercise_spec.ml (both opens)
- exercises/23-ppx-and-deriving/test/exercise_spec.ml (both opens)
- exercises/24-domains-and-concurrency/test/exercise_spec.ml (both opens)
- exercises/25-algebraic-effects/test/exercise_spec.ml (both opens)
- exercises/26-format-and-pp/test/exercise_spec.ml (only `open Alcotest`)
- exercises/27-lazy-and-memoization/test/exercise_spec.ml (only `open Alcotest`)
- exercises/28-parsing/test/exercise_spec.ml (only `open Alcotest`)
- exercises/29-c-interop/test/exercise_spec.ml (only `open Alcotest`)
- exercises/30-profiling-optimization/test/exercise_spec.ml (only `open Alcotest`)

IMPORTANT EXCEPTIONS:
- For exercises 21-22, the tests reference GADT constructors (Empty_stack, Push, VCons, VNil,
  HCons, HNil, Lit_int, Lit_bool, Add, If, Eq) that are defined in Exercise. These must be
  qualified as Exercise.Empty_stack etc, OR use a local `let open Exercise in` inside
  individual test functions where many constructors are used. Prefer local opens for readability.
- For exercise 23, tests reference Exercise.Red, Exercise.Green, Exercise.Blue, Exercise.Leaf,
  Exercise.Node, Exercise.show_color, Exercise.equal_color, Exercise.compare_color, and
  record fields {x; y}. Use local opens or qualify.
- For exercise 25, tests reference Exercise.Log, Exercise.Get, Exercise.Put, Exercise.Abort
  effect constructors. Use local opens or qualify.
- Exercise 28 has a helper `ok_testable` that uses `Alcotest.result` and `Alcotest.string` —
  make sure those stay qualified.
- Exercise 29 has a comment-based alias `let int_t = Alcotest.int` — keep that.
- Exercise 30 has `Unix.sleepf` — that's unrelated to this change.

For each file, verify it still compiles after changes: cd exercises/NN-*/ && dune build
```

---

## Prompt 7: Create solution.ml for all exercises that don't have one

```
The validate-all.sh script expects lib/solution.ml in each exercise directory. Exercises 01 and
21-25 should already have solution.ml from Prompts 2 and 3. Create solution.ml for all remaining
exercises (02-20 and 26-30).

For each exercise, the solution.ml must:
1. Have the SAME type definitions, module types, and structure as exercise.ml
2. Replace every `failwith "not implemented"` with a correct working implementation
3. Pass ALL tests in test/exercise_spec.ml when swapped in for exercise.ml

CRITICAL: Do NOT modify test/exercise_spec.ml files. The solution must pass the existing tests.

For each exercise, after creating solution.ml, validate it works:
  cp lib/exercise.ml lib/exercise.ml.bak
  cp lib/solution.ml lib/exercise.ml
  dune test
  cp lib/exercise.ml.bak lib/exercise.ml
  rm lib/exercise.ml.bak

If any solution fails tests, fix it before moving on.

Create solutions for these exercises in order:
02-types-and-values, 03-functions, 04-pattern-matching, 05-conditionals, 06-lists,
07-recursion, 08-higher-order-functions, 09-variants-and-records, 10-modules-and-signatures,
11-option-and-result, 12-map-and-set, 13-sequences-and-arrays, 14-strings-and-buffers,
15-io-and-refs, 16-exceptions, 17-mutable-state, 18-advanced-modules, 19-data-structures,
20-tail-recursion, 26-format-and-pp, 27-lazy-and-memoization, 28-parsing, 29-c-interop,
30-profiling-optimization

Then run the full validator: ./scripts/validate-all.sh
```

---

## Prompt 8 (optional): Add a minimal CI workflow

```
Create .github/workflows/test.yml that runs all exercise tests on push and PR.

Requirements:
- Use ubuntu-latest
- Install OCaml 5.2 via ocaml/setup-ocaml@v3 action
- Install alcotest, ppx_deriving, and angstrom via opam
- Run: for dir in exercises/*/; do (cd "$dir" && dune build); done
  to verify all skeletons compile
- Run: ./scripts/validate-all.sh
  to verify all solutions pass

Keep the workflow simple — one job, sequential steps.
```
