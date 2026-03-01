# Exercise 29 — C Interop and Bigarray

## Theory

### The `external` Keyword

OCaml can call C functions via *foreign function interface* (FFI) declarations:

```ocaml
external my_func : int -> int = "c_my_func"
```

This tells the compiler that `my_func` is implemented in C under the symbol `c_my_func`. The C stub receives OCaml values wrapped in the `value` type and must use the `CAMLparam` / `CAMLreturn` macros to cooperate with the garbage collector.

### Boxed vs Unboxed Values

OCaml values are generally *boxed*: they live on the GC heap with a tag word. Integers (and characters, booleans) are a special case — they are *unboxed* and represented directly as tagged integers in C (`Val_int` / `Int_val` macros). Floats in polymorphic context are boxed; floats in `float array` are stored unboxed for efficiency.

When passing large buffers to C, boxing every byte would be prohibitively expensive. That's where `Bigarray` comes in.

### Bigarray for Zero-Copy Interop

`Bigarray.Array1.t` is a one-dimensional array backed by a plain C pointer with no GC involvement. Its layout and element kind are tracked at the type level:

```ocaml
type buffer = (int, int8_unsigned_elt, c_layout) Array1.t
```

Because a `Bigarray` is just a C array, a C stub can receive it, cast `Data_custom_val(v)` to the appropriate C pointer, and read/write bytes directly — no copying, no boxing overhead.

### The `ctypes` Library

For more ergonomic FFI without writing C stubs by hand, the `ctypes` library allows describing C function signatures directly in OCaml:

```ocaml
let memset = foreign "memset" (ptr void @-> int @-> size_t @-> returning (ptr void))
```

`ctypes` handles all the marshalling automatically.

### When to Use C Stubs

Use C stubs when you need access to OS APIs, performance-critical numeric kernels, or existing C libraries. For simple cases, `Bytes` and `Bigarray` often let you stay in pure OCaml while sharing memory safely.

---

## Practice Assignments

### Assignment 1: create_buffer
Implement `create_buffer n` that allocates a zero-filled `Bigarray` of `n` bytes using `Array1.create`.

### Assignment 2: buffer_fill
Implement `buffer_fill buf v` that sets every element of `buf` to `v` using a `for` loop.

### Assignment 3: buffer_sum
Implement `buffer_sum buf` that returns the integer sum of all bytes in `buf`.

### Assignment 4: buffer_to_string and bytes_to_buffer
Implement conversions between `buffer` and `Bytes`. Iterate over indices and copy byte-by-byte.

### Assignment 5: xor_buffers
Implement `xor_buffers a b` returning a new buffer where each byte is `a.(i) lxor b.(i)`. Raise `Invalid_argument` if lengths differ.
