module type COMPARABLE = sig
  type t

  val compare : t -> t -> int
end

module PriorityQueue (C : COMPARABLE) : sig
  type t

  val empty : t
  val insert : C.t -> t -> t
  val pop_min : t -> (C.t * t) option
  val size : t -> int
end = struct
  type t = C.t list

  let empty = []

  let insert x q =
    let rec ins = function
      | [] -> [ x ]
      | h :: t as lst -> if C.compare x h <= 0 then x :: lst else h :: ins t
    in
    ins q

  let pop_min = function [] -> None | h :: t -> Some (h, t)
  let size q = List.length q
end

module type RING_BUFFER = sig
  type 'a t

  val make : int -> 'a t
  val push : 'a -> 'a t -> 'a t
  val to_list : 'a t -> 'a list
  val size : 'a t -> int
  val capacity : 'a t -> int
end

module RingBuffer : RING_BUFFER = struct
  type 'a t =
    { buf : 'a option array
    ; cap : int
    ; mutable head : int
    ; mutable len : int
    }
  [@@warning "-69"]

  let make cap = { buf = Array.make cap None; cap; head = 0; len = 0 }

  let push x rb =
    let pos = (rb.head + rb.len) mod rb.cap in
    rb.buf.(pos) <- Some x;
    if rb.len < rb.cap then rb.len <- rb.len + 1
    else rb.head <- (rb.head + 1) mod rb.cap;
    rb

  let to_list rb =
    List.init rb.len (fun i ->
        match rb.buf.((rb.head + i) mod rb.cap) with
        | Some x -> x
        | None -> failwith "unreachable")

  let size rb = rb.len
  let capacity rb = rb.cap
end
