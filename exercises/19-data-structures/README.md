# Exercise 19 — Data Structures

## Theory

Choosing the right data structure is critical for both correctness and performance. OCaml's standard library provides a rich set of options.

### Map vs Hashtbl

| | `Map.Make` | `Hashtbl` |
|---|---|---|
| Mutability | **Persistent** (functional) | **Mutable** (imperative) |
| Lookup | O(log n) | O(1) average |
| Ordering | Keys always sorted | No ordering |
| Best for | Functional pipelines, snapshots | High-frequency updates |

`Map.Make(K)` is a functor producing a balanced BST map keyed on type `K`. Operations return new maps; the original is unchanged.

### Set

`Set.Make(E)` produces a persistent set backed by a balanced BST. Use it when you need fast membership tests, sorted iteration, or set algebra (`union`, `inter`, `diff`).

### Binary Search Tree (BST)

A hand-rolled BST gives you full control and is a great exercise in recursive data structures:

```ocaml
type 'a bst = Leaf | Node of 'a bst * 'a * 'a bst
```

- **Insert**: compare and recurse left or right.
- **Membership**: same structure as insert.
- **In-order traversal**: left subtree → root → right subtree yields sorted output.

Note: a naive BST can degrade to O(n) on sorted input. Production code uses self-balancing trees (AVL, Red-Black) as found in `Map` and `Set`.

### Queue and Stack

Use `Queue` for FIFO access and `Stack` for LIFO. Both are mutable and O(1) for their primary operations.

### Time complexity summary

| Structure | Insert | Lookup | Delete | Ordered? |
|---|---|---|---|---|
| `List` | O(1) prepend | O(n) | O(n) | No |
| `Array` | O(n) | O(1) | O(n) | No |
| `Map` / `Set` | O(log n) | O(log n) | O(log n) | Yes |
| `Hashtbl` | O(1) avg | O(1) avg | O(1) avg | No |
| Naive BST | O(n) worst | O(n) worst | — | Yes |

---

## Practice Assignments

### Assignment 1: frequency_map
Build an `IntMap` from element to count for a given list.

### Assignment 2: top_n
Return the `n` map entries with the highest values, sorted by value descending.

### Assignment 3: bst_insert and bst_mem
Implement insertion and membership for the polymorphic BST type.

### Assignment 4: bst_to_sorted_list
Implement in-order traversal returning all elements in sorted order.

### Assignment 5: anagram_groups
Group a list of words by their sorted-character signature using `StringMap`.
