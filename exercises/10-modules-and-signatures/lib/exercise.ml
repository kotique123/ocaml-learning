(** A simple stack implemented as a module. *)
module Stack : sig
  type 'a t
  val empty : 'a t
  val push : 'a -> 'a t -> 'a t
  val pop : 'a t -> ('a * 'a t) option
  val is_empty : 'a t -> bool
  val size : 'a t -> int
end = struct
  type 'a t = 'a list
  let empty = []
  let push x s = failwith "not implemented"
  let pop s = failwith "not implemented"
  let is_empty s = failwith "not implemented"
  let size s = failwith "not implemented"
end

(** A simple queue implemented as a module. *)
module Queue : sig
  type 'a t
  val empty : 'a t
  val enqueue : 'a -> 'a t -> 'a t
  val dequeue : 'a t -> ('a * 'a t) option
  val is_empty : 'a t -> bool
  val size : 'a t -> int
end = struct
  type 'a t = { front : 'a list; rear : 'a list }
  let empty = { front = []; rear = [] }
  let enqueue x q = failwith "not implemented"
  let dequeue q = failwith "not implemented"
  let is_empty q = failwith "not implemented"
  let size q = failwith "not implemented"
end

(** A counter module with encapsulated state. *)
module Counter : sig
  type t
  val make : int -> t
  val increment : t -> t
  val decrement : t -> t
  val value : t -> int
  val reset : t -> t
end = struct
  type t = int
  let make n = failwith "not implemented"
  let increment c = failwith "not implemented"
  let decrement c = failwith "not implemented"
  let value c = failwith "not implemented"
  let reset c = failwith "not implemented"
end
