(** [greet name] returns ["Hello, " ^ name ^ "!"] *)
let greet (_name : string) : string = failwith "not implemented"

(** [double n] returns [n * 2] *)
let double (_n : int) : int = failwith "not implemented"

(** [circle_area r] returns the area of a circle with radius [r]. Use Float.pi. *)
let circle_area (_r : float) : float = failwith "not implemented"

(** [bmi weight height] returns "Underweight", "Normal", or "Overweight".
    BMI = weight /. (height *. height). Thresholds: <18.5 Under, <25.0 Normal, else Over. *)
let bmi (_weight : float) (_height : float) : string = failwith "not implemented"
