(** A generic priority queue backed by a sorted list.
    COMPARABLE is a module type providing a comparison function. *)
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
  type t = C.t list (* kept sorted *)
  let empty = []
  let insert x q = failwith "not implemented"
  let pop_min q = failwith "not implemented"
  let size q = failwith "not implemented"
end

(** A generic ring buffer (fixed-size circular buffer). *)
module type RING_BUFFER = sig
  type 'a t
  val make : int -> 'a t
  val push : 'a -> 'a t -> 'a t  (* drops oldest element when full *)
  val to_list : 'a t -> 'a list  (* oldest first *)
  val size : 'a t -> int
  val capacity : 'a t -> int
end

module RingBuffer : RING_BUFFER = struct
  type 'a t = { buf : 'a option array; cap : int; mutable head : int; mutable len : int }
  [@@warning "-69"]
  let make cap = failwith "not implemented"
  let push x rb = failwith "not implemented"
  let to_list rb = failwith "not implemented"
  let size rb = failwith "not implemented"
  let capacity rb = failwith "not implemented"
end
