module StringMap = Map.Make (String)
module IntSet = Set.Make (Int)
module IntMap = Map.Make (Int)

let word_count (words : string list) : int StringMap.t =
  List.fold_left
    (fun m w ->
      let n = try StringMap.find w m with Not_found -> 0 in
      StringMap.add w (n + 1) m)
    StringMap.empty words

let most_frequent (map : int StringMap.t) : (string * int) option =
  StringMap.fold
    (fun k v acc ->
      match acc with
      | None -> Some (k, v)
      | Some (_, best) -> if v > best then Some (k, v) else acc)
    map None

let unique_ints (lst : int list) : IntSet.t =
  List.fold_left (fun s x -> IntSet.add x s) IntSet.empty lst

let intersection_count (s1 : IntSet.t) (s2 : IntSet.t) : int =
  IntSet.cardinal (IntSet.inter s1 s2)

let invert_map (m : int StringMap.t) : string IntMap.t =
  StringMap.fold (fun k v acc -> IntMap.add v k acc) m IntMap.empty
