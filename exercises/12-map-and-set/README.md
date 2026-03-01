# Exercise 12 — Maps and Sets

## Theory

OCaml's standard library ships purely functional, balanced-tree implementations of ordered maps and sets. Access to them is granted through **functors** — module-level functions that take a module as input and produce a new, specialised module as output.

### Functors: `Map.Make` and `Set.Make`

```ocaml
module StringMap = Map.Make(String)   (* keys are strings *)
module IntSet    = Set.Make(Int)      (* elements are ints *)
module IntMap    = Map.Make(Int)      (* keys are ints *)
```

Each argument module must expose a `compare : t -> t -> int` function (both `String` and `Int` from the standard library already do). The resulting modules have their own types (`'a StringMap.t`, `IntSet.t`) and a rich set of operations.

### Key Properties

- **Persistent (purely functional):** `StringMap.add` returns a *new* map; the original binding is unchanged. No mutation ever occurs.
- **Sorted keys:** Iteration always visits bindings in ascending order according to the comparator supplied to `Map.Make`.
- **O(log n) operations:** Backed by balanced AVL trees.

### Common Map Operations

```ocaml
let m = StringMap.empty
let m = StringMap.add "key" 42 m
let v = StringMap.find "key" m          (* raises Not_found *)
let v = StringMap.find_opt "key" m      (* returns option *)
let m = StringMap.remove "key" m
(* aggregate all values *)
let total = StringMap.fold (fun _k v acc -> acc + v) m 0
```

### Set Operations

Sets support the classical mathematical operations:

| Function | Meaning |
|---|---|
| `IntSet.union s1 s2` | All elements in either set |
| `IntSet.inter s1 s2` | Elements present in both sets |
| `IntSet.diff s1 s2` | Elements in `s1` but not `s2` |
| `IntSet.cardinal s` | Number of elements |

### Folding Over Maps

`Map.S.fold f m acc` visits every `(key, value)` pair in ascending key order, accumulating a result — the primary way to aggregate data from a map without mutation.

## Practice Assignments

### Assignment 1: word_count
Build a frequency map from a list of words using `StringMap`.
### Assignment 2: most_frequent
Scan a word-count map to find the entry with the highest count.
### Assignment 3: unique_ints
Collect integers from a list into an `IntSet`, discarding duplicates.
### Assignment 4: intersection_count
Return the number of elements shared by two `IntSet` values.
### Assignment 5: invert_map
Swap keys and values, turning a `StringMap int` into an `IntMap string`.
