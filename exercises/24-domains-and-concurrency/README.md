# Exercise 24 — Domains and Concurrency

## Theory

### OCaml 5 Multicore

OCaml 5 introduced **true parallelism** through the `Domain` module. Before OCaml 5, the Global Interpreter Lock (GIL) prevented multiple threads from running OCaml code simultaneously. Now, each `Domain` maps to an OS thread and can run on a separate CPU core.

### Domain.spawn and Domain.join

```ocaml
let d = Domain.spawn (fun () -> expensive_computation ()) in
let result = Domain.join d
```

`Domain.spawn` starts a new domain running the given function. `Domain.join` blocks until the domain finishes and returns its result. Spawning one domain per list element gives a simple parallel map.

### Data Races and Mutation

When multiple domains share mutable state, **data races** occur if accesses are not synchronised. A data race can corrupt memory and produce unpredictable results. OCaml 5 provides two primitives to prevent them:

**Mutex (blocking):** `Mutex.lock` acquires exclusive ownership; other domains trying to lock the same mutex will *block* until it is released. Use `Mutex.unlock` in all paths (or `Mutex.protect` for safety). This is simple but adds latency when contention is high.

**Atomic (lock-free):** `Atomic.make`, `Atomic.get`, `Atomic.set`, and `Atomic.fetch_and_add` perform indivisible read-modify-write operations using CPU hardware instructions. No domain ever blocks; instead they retry or succeed immediately. Lock-free operations are faster under low contention and cannot deadlock.

### When to Use Parallel Map

Parallel map is beneficial when:
- The list is large enough that spawning overhead is amortised.
- Each element's computation is independent (no shared state).
- The function is CPU-bound (not I/O-bound where async is more appropriate).

For small lists or cheap functions, sequential `List.map` is faster.

---

## Practice Assignments

**Assignment 1 — parallel_map:** Spawn one domain per element using `Domain.spawn`, collect all domain handles, then `Domain.join` each in order to preserve the original ordering.

**Assignment 2 — parallel_sum:** Split the list in half, compute each half's sum in a separate domain, and add the results. Handle the empty list as a special case.

**Assignment 3 — thread_safe_counter:** Build a counter using a `ref` protected by a `Mutex`. Implement `increment` with lock/unlock around `incr`, and `get` with lock/unlock around the read.

**Assignment 4 — atomic_counter:** Build a lock-free counter using `Atomic.make 0`. Use `Atomic.fetch_and_add` to increment and `Atomic.get` to read.
