(** [greet name] returns ["Hello, " ^ name ^ "!"] *)
let greet (name : string) : string
    = "Hello, " ^ name ^ "!" 

(** [double n] returns [n * 2] *)
let double (n : int) : int
    = 2 * n

(** [circle_area r] returns the area of a circle with radius [r]. Use Float.pi. *)
let circle_area (r : float) : float
    = Float.pi *. r *. r

(** [bmi weight height] returns "Underweight", "Normal", or "Overweight".
    BMI = weight /. (height *. height). Thresholds: <18.5 Under, <25.0 Normal, else Over. *)
let bmi (weight : float) (height : float) : string = 
    let bmi_value = weight /. (height *. height) in
    if bmi_value < 18.5 then "Underweight"
    else if bmi_value <= 25.0 then "Normal"
    else "Overweight"