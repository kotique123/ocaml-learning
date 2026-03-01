let pp_list (pp_elem : Format.formatter -> 'a -> unit) (ppf : Format.formatter) (lst : 'a list) : unit =
  Format.fprintf ppf "[%a]"
    (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "; ") pp_elem)
    lst

type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

let pp_tree (pp_val : Format.formatter -> 'a -> unit) (ppf : Format.formatter) (t : 'a tree) : unit =
  let rec go ppf = function
    | Leaf -> Format.pp_print_string ppf "."
    | Node (l, v, r) -> Format.fprintf ppf "(%a %a %a)" go l pp_val v go r
  in
  go ppf t

let pp_record (ppf : Format.formatter) (fields : (string * string) list) : unit =
  match fields with
  | [] -> Format.pp_print_string ppf "{  }"
  | _ ->
    let pp_field ppf (k, v) = Format.fprintf ppf "%s = %s" k v in
    Format.fprintf ppf "{ %a }"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "; ") pp_field)
      fields

let format_table (headers : string list) (rows : string list list) : string =
  let all_rows = headers :: rows in
  let ncols = List.length headers in
  let col_widths = Array.make ncols 0 in
  List.iter (fun row ->
    List.iteri (fun i cell ->
      if i < ncols then
        col_widths.(i) <- max col_widths.(i) (String.length cell)
    ) row
  ) all_rows;
  let pad s w = s ^ String.make (max 0 (w - String.length s)) ' ' in
  let row_to_string row =
    "| " ^
    String.concat " | "
      (List.mapi (fun i cell -> pad cell (if i < ncols then col_widths.(i) else String.length cell)) row)
    ^ " |"
  in
  let sep =
    "+" ^
    String.concat "+"
      (Array.to_list (Array.map (fun w -> String.make (w + 2) '-') col_widths))
    ^ "+"
  in
  String.concat "\n" ([sep; row_to_string headers; sep] @ List.map row_to_string rows @ [sep])
