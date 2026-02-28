(** [sum lst] returns the sum of all integers in [lst]. Use List.fold_left. *)
let sum (lst : int list) : int = failwith "not implemented"

(** [product lst] returns the product of all integers in [lst]. *)
let product (lst : int list) : int = failwith "not implemented"

(** [evens lst] returns only the even integers in [lst]. *)
let evens (lst : int list) : int list = failwith "not implemented"

(** [double_all lst] returns a new list with every element doubled. *)
let double_all (lst : int list) : int list = failwith "not implemented"

(** [my_last lst] returns [Some x] where x is the last element, or [None] if empty. *)
let my_last (lst : 'a list) : 'a option = failwith "not implemented"

(** [zip lst1 lst2] pairs up elements: [(1,4);(2,5);(3,6)] from [1;2;3] and [4;5;6].
    Stop at the shorter list. *)
let zip (lst1 : 'a list) (lst2 : 'b list) : ('a * 'b) list = failwith "not implemented"

(** [flatten lst] flattens a list of lists into a single list. *)
let flatten (lst : 'a list list) : 'a list = failwith "not implemented"
