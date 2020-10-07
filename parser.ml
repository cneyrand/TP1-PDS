open ASD
open Token

(* This gives some stream parser usage examples. You can discard them once you understood the syntax *)
(* These are high-level generic functions: they take a parser as argument *)
(* p? *)
let opt p = parser
  | [< x = p >] -> Some x
  | [<>] -> None

(* p* *)
let rec many p = parser
  | [< x = p; l = many p >] -> x :: l
  | [<>] -> []

(* p+ *)
let some p = parser
  | [< x = p; l = many p >] -> x :: l

let parse_object : token Stream.t -> objet = parser
  | [< 'BRAC; 'STR str; 'KET >] -> OBJET(str)
  | [< 'QUOTES; 'STR str; 'QUOTES >] -> STRING(str)

let parse_object_and_comma : token Stream.t -> objet = parser
  | [< 'COMMA; o = parse_object >] -> o

let parse_verb_and_semicolon : token Stream.t -> predicat = parser
 | [< 'SEMICOLON; 'BRAC; 'STR str; 'KET;  o = parse_object; l = many parse_object_and_comma >] -> PREDICAT(str, o :: l)

let parse_verb : token Stream.t -> predicat = parser
  | [< 'BRAC; 'STR str; 'KET;  o = parse_object; l = many parse_object_and_comma >] -> PREDICAT(str, o :: l)


let parse_subject : token Stream.t -> sujet =  parser
  | [< 'BRAC; 'STR str; 'KET; v = parse_verb; l = many parse_verb_and_semicolon; 'DOT >] -> SUJET(str, v :: l)

let parse : token Stream.t -> turtle = parser
| [< l = many parse_subject >] -> PHRASE(l)
