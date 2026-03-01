module IntMap = Map.Make (Int)
module StringSet = Set.Make (String)

let frequency_map (lst : int list) : int IntMap.t =
  List.fold_left
    (fun m x ->
      let n = try IntMap.find x m with Not_found -> 0 in
      IntMap.add x (n + 1) m)
    IntMap.empty lst

let top_n (n : int) (map : int IntMap.t) : (int * int) list =
  let lst = IntMap.bindings map in
  let sorted =
    List.sort
      (fun (k1, v1) (k2, v2) ->
        let c = compare v2 v1 in
        if c <> 0 then c else compare k1 k2)
      lst
  in
  let rec take n lst =
    match (n, lst) with
    | 0, _ | _, [] -> []
    | n, h :: t -> h :: take (n - 1) t
  in
  take n sorted

type 'a bst = Leaf | Node of 'a bst * 'a * 'a bst

let rec bst_insert (x : 'a) (t : 'a bst) : 'a bst =
  match t with
  | Leaf -> Node (Leaf, x, Leaf)
  | Node (l, v, r) ->
    if x < v then Node (bst_insert x l, v, r)
    else if x > v then Node (l, v, bst_insert x r)
    else t

let rec bst_mem (x : 'a) (t : 'a bst) : bool =
  match t with
  | Leaf -> false
  | Node (l, v, r) ->
    if x = v then true else if x < v then bst_mem x l else bst_mem x r

let bst_to_sorted_list (t : 'a bst) : 'a list =
  let rec aux acc = function
    | Leaf -> acc
    | Node (l, v, r) -> aux (v :: aux acc r) l
  in
  aux [] t

module StringMap = Map.Make (String)

let anagram_groups (words : string list) : string list StringMap.t =
  let signature word =
    let chars = Array.init (String.length word) (fun i -> word.[i]) in
    Array.sort Char.compare chars;
    String.init (Array.length chars) (fun i -> chars.(i))
  in
  List.fold_left
    (fun m w ->
      let sig_ = signature w in
      let group = try StringMap.find sig_ m with Not_found -> [] in
      StringMap.add sig_ (w :: group) m)
    StringMap.empty words
