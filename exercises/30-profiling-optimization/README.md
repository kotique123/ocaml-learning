# Exercise 30 — Profiling and Optimization

## Theory

### Measuring Performance in OCaml

The simplest way to time a piece of code is `Sys.time ()`, which returns the CPU time in seconds as a `float`. Taking the difference before and after a computation gives elapsed CPU seconds:

```ocaml
let t0 = Sys.time () in
let result = f () in
let elapsed = Sys.time () -. t0 in
(result, elapsed)
```

For wall-clock time, use `Unix.gettimeofday ()`. For finer-grained profiling, the `landmarks` library instruments functions automatically.

### GC Pressure and Allocation Avoidance

Every heap allocation eventually costs GC time. Common sources of hidden allocation:

- **Closures**: capturing values allocates a closure record.
- **Tuples and records** returned from functions.
- **Boxed floats**: a `float` in a polymorphic container is heap-allocated. A `float array` is the exception — OCaml stores its elements unboxed, making `float array` ideal for numeric work.

Strategies to reduce allocation: use `array` instead of `list` for fixed-size data, prefer tail-recursive accumulators, and avoid constructing intermediate lists.

### Array vs List: Cache Locality

Arrays store elements contiguously in memory; the CPU prefetcher handles sequential access well. Linked lists scatter nodes across the heap, causing cache misses. For large numeric sequences, an array sum with a `for` loop will typically outperform a `List.fold_left` on the same data by a significant margin.

### Tail Recursion: `fold_right` vs `fold_left`

`List.fold_right` is *not* tail-recursive: it builds a call stack proportional to the list length, risking a stack overflow on large inputs. `List.fold_left` is tail-recursive and is the correct choice for summing large lists.

### The Sieve of Eratosthenes

The sieve is a classic imperative algorithm: allocate a boolean array of size `n+1`, then for each prime `p`, mark all its multiples as composite. It runs in O(n log log n) time and is naturally expressed with mutable arrays in OCaml.

---

## Practice Assignments

### Assignment 1 — `time_it`
Implement `time_it f` using `Sys.time` to measure the CPU time of `f ()`. Return `(result, elapsed)`.

### Assignment 2 — `sum_list_naive`
Implement `sum_list_naive` using `List.fold_right`. Note: this is not tail-recursive.

### Assignment 3 — `sum_list_fast`
Implement `sum_list_fast` using `List.fold_left` with an accumulator. Verify it agrees with `sum_list_naive`.

### Assignment 4 — `sum_array`
Implement `sum_array` using a `for` loop — the most cache-friendly approach.

### Assignment 5 — `float_array_dot`
Implement `float_array_dot a b` computing `Σ a.(i) *. b.(i)` using a `for` loop. Unboxed float arrays make this fast.

### Assignment 6 — `sieve_of_eratosthenes`
Implement the sieve using a `bool array`. Return all primes ≤ `n` in ascending order as an `int list`.

### Assignment 7 — `merge_sort`
Implement `merge_sort` on `int list`. Split the list, recursively sort each half, then merge. Keep it purely functional (no mutation).
