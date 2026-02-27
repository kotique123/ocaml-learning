(** [array_sum arr] returns the sum of all elements in [arr]. *)
let array_sum (_arr : int array) : int = failwith "not implemented"

(** [array_rotate arr n] returns a new array rotated left by [n] positions.
    E.g. rotate [|1;2;3;4;5|] 2 = [|3;4;5;1;2|] *)
let array_rotate (_arr : 'a array) (_n : int) : 'a array = failwith "not implemented"

(** [running_total arr] returns a new array where each element is the cumulative sum.
    E.g. [|1;2;3;4|] -> [|1;3;6;10|] *)
let running_total (_arr : int array) : int array = failwith "not implemented"

(** [naturals ()] returns a Seq.t of natural numbers 0, 1, 2, 3, ... (infinite). *)
let naturals () : int Seq.t = failwith "not implemented"

(** [seq_take n seq] returns the first [n] elements of [seq] as a list. *)
let seq_take (_n : int) (_seq : 'a Seq.t) : 'a list = failwith "not implemented"

(** [seq_squares n] returns the first [n] perfect squares as a list: [1;4;9;16;...] *)
let seq_squares (_n : int) : int list = failwith "not implemented"
