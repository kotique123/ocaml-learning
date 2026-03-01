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
  let push x s = x :: s
  let pop = function
    | [] -> None
    | x :: rest -> Some (x, rest)
  let is_empty s = s = []
  let size s = List.length s
end

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
  let enqueue x q = { q with rear = x :: q.rear }
  let dequeue q =
    match q.front with
    | x :: rest -> Some (x, { q with front = rest })
    | [] ->
      (match List.rev q.rear with
       | [] -> None
       | x :: rest -> Some (x, { front = rest; rear = [] }))
  let is_empty q = q.front = [] && q.rear = []
  let size q = List.length q.front + List.length q.rear
end

module Counter : sig
  type t
  val make : int -> t
  val increment : t -> t
  val decrement : t -> t
  val value : t -> int
  val reset : t -> t
end = struct
  type t = { initial : int; current : int }
  let make n = { initial = n; current = n }
  let increment c = { c with current = c.current + 1 }
  let decrement c = { c with current = c.current - 1 }
  let value c = c.current
  let reset c = { c with current = c.initial }
end
