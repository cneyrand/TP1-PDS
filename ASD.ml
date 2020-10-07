(* ASD type *)

(* This is my ASD *)
type objet = STRING of string | OBJET of string
type predicat = PREDICAT of string * objet list
type sujet = SUJET of string * predicat list
type turtle = PHRASE of sujet list

(* Exploration récursive de l'AST pour générer les triplets *)
let rec ntriples_of_ast_aux (ast : turtle) =
  match ast with
  | PHRASE(sujets) -> List.flatten (List.map ntriples_of_sujet sujets)

and ntriples_of_sujet (sujet : sujet) =
      match sujet with
      | SUJET(nom, predicats) -> List.map (fun elem -> "<" ^ nom ^ "> " ^ elem ^ ".\n")(List.flatten (List.map ntriples_of_predicat predicats))
and ntriples_of_predicat (predicat : predicat) =
      match predicat with
      | PREDICAT(nom, objets) -> List.map (fun elem -> " <" ^ nom ^ "> " ^ elem)(List.flatten (List.map ntriples_of_objet objets))
and ntriples_of_objet (objet : objet) =
      match objet with
      | STRING(nom) -> [" \"" ^ nom ^ "\""]
      | OBJET(nom) -> [" <" ^ nom ^ ">"]
;;

let ntriples_of_ast (ast : turtle) =
  List.fold_left (^) ("") (ntriples_of_ast_aux ast)
