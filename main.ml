open Lexer
open Parser
open ASD

let () =
  (* Use with a manually made AST *)

  (* Use with lexer and parser *)

  let lexbuf = Lexing.from_channel stdin
  in try
    let token_stream = Stream.of_list (Lexer.tokenize lexbuf)
    in let ast = Parser.parse token_stream
    in let result = ASD.ntriples_of_ast ast

    in print_endline result
  with Lexer.Unexpected_character e ->
  begin
    Printf.printf
      "Unexpected character: `%c' at position '%d' on line '%d'\n"
      e.character e.pos e.line;
    exit 1
  end
