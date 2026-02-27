# Exercise 06 — Lists

## Theory

Lists are one of the most fundamental data structures in OCaml. A list is an
ordered, immutable sequence of elements all sharing the same type.

### List Literals and the Cons Operator

An empty list is written `[]`. You build lists using the **cons** operator
`::`, which prepends an element to an existing list:

```ocaml
let lst = 1 :: 2 :: 3 :: []   (* same as [1; 2; 3] *)
```

The syntax `[1; 2; 3]` is just syntactic sugar for the `::` chain above.

### Pattern Matching on Lists

Pattern matching is the idiomatic way to deconstruct lists:

```ocaml
match lst with
| []      -> (* empty case *)
| x :: xs -> (* x is head, xs is the tail *)
```

You can nest patterns to match deeper structure, e.g. `x :: y :: rest`.

### Immutability

OCaml lists are **immutable**: operations like `List.rev` or `@` return new
lists and never modify the original. This makes reasoning about code much
easier and is safe to share across threads.

### Key Functions in the `List` Module

| Function | Signature | Description |
|----------|-----------|-------------|
| `List.length` | `'a list -> int` | Number of elements |
| `List.rev` | `'a list -> 'a list` | Reverse a list |
| `List.append` / `@` | `'a list -> 'a list -> 'a list` | Concatenate |
| `List.map` | `('a -> 'b) -> 'a list -> 'b list` | Transform every element |
| `List.filter` | `('a -> bool) -> 'a list -> 'a list` | Keep matching elements |
| `List.fold_left` | `('acc -> 'a -> 'acc) -> 'acc -> 'a list -> 'acc` | Left fold (accumulate) |
| `List.fold_right` | `('a -> 'acc -> 'acc) -> 'a list -> 'acc -> 'acc` | Right fold |
| `List.nth` | `'a list -> int -> 'a` | Element at index (0-based) |
| `List.mem` | `'a -> 'a list -> bool` | Membership test |
| `List.sort` | `('a -> 'a -> int) -> 'a list -> 'a list` | Sort with comparator |

### Fold in Depth

`List.fold_left f acc [a; b; c]` computes `f (f (f acc a) b) c` — it processes
elements from left to right, carrying an accumulator. This single function can
express sum, product, reversal, and much more.

---

## Practice Assignments

### Assignment 1: sum
Write `sum : int list -> int` that returns the sum of all integers in the list.
Return `0` for an empty list. Implement it using `List.fold_left`.

### Assignment 2: product
Write `product : int list -> int` that returns the product of all integers.
Return `1` for an empty list (the multiplicative identity).

### Assignment 3: evens
Write `evens : int list -> int list` that returns only the even integers,
preserving their original order.

### Assignment 4: double_all
Write `double_all : int list -> int list` that returns a new list where every
element has been multiplied by 2.

### Assignment 5: my_last
Write `my_last : 'a list -> 'a option` that returns `Some x` where `x` is the
last element, or `None` if the list is empty. Do not use `List.nth`.

### Assignment 6: zip
Write `zip : 'a list -> 'b list -> ('a * 'b) list` that pairs up corresponding
elements from two lists into tuples. Stop when the shorter list runs out.

### Assignment 7: flatten
Write `flatten : 'a list list -> 'a list` that concatenates a list of lists
into a single flat list, preserving order.
