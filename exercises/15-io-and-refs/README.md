# Exercise 15 — I/O and Refs

## Theory

OCaml is a mostly functional language, but it deliberately supports imperative programming when mutation is the clearest tool for the job.

### Mutable References with `ref`

A **reference cell** holds a single mutable value of any type:

```ocaml
let x = ref 0       (* create a ref holding 0; type: int ref *)
let v = !x          (* dereference — read the value: v = 0 *)
x := 42             (* assign — x now holds 42 *)
incr x              (* shorthand: x := !x + 1 *)
decr x              (* shorthand: x := !x - 1 *)
```

Under the hood, `ref` is just a record with one mutable field:
`type 'a ref = { mutable contents : 'a }`. The `!` operator reads `contents`; `:=` writes it.

### When to Use Refs

Refs are most natural for:

- **Counters and accumulators** inside imperative algorithms
- **Memoization** — caching computed results in a `Hashtbl`
- **Running aggregates** (sums, counts, averages) accumulated over time
- **File I/O** — collecting lines read one-by-one from a channel

Avoid refs whenever a clean functional approach exists; unnecessary mutation makes code harder to reason about and test.

### Memoization Pattern

Combine a `Hashtbl` with a closure to cache function results:

```ocaml
let memoize f =
  let cache = Hashtbl.create 16 in
  fun x ->
    match Hashtbl.find_opt cache x with
    | Some v -> v
    | None   -> let v = f x in Hashtbl.add cache x v; v
```

The closure captures `cache`, which lives for the lifetime of the memoized function.

### Basic File I/O

```ocaml
(* Reading line by line *)
let ic = open_in "file.txt" in
(try
  while true do
    let line = input_line ic in   (* raises End_of_file at EOF *)
    print_endline line
  done
with End_of_file -> ());
close_in ic

(* Writing *)
let oc = open_out "file.txt" in
output_string oc "hello\n";
close_out oc
```

Always close channels. For exception safety wrap the body in `Fun.protect` or `try … finally`.

### Printing

```ocaml
print_string "no newline"
print_endline "with newline"
Printf.printf "formatted: %d %.2f\n" 42 3.14
```

## Practice Assignments

1. **Assignment 1: make_counter** — Use a `ref` inside a closure to build an increment/read counter pair.
2. **Assignment 2: memoize** — Implement generic memoization with `Hashtbl`, caching each argument the first time it is seen.
3. **Assignment 3: read_lines / write_lines** — Read all lines from a file into a list; write a list of strings to a file one per line.
4. **Assignment 4: running_average** — Track a running mean using mutable state; return an add/query function pair.
