{
  open Lexing
  open Token

  type error = {
    character: char;
    line: int;
    pos: int;
  }

  exception Unexpected_character of error
}

(************************************************)

let blanks    = [' ' '\t' '\n']

rule tokenize = parse

  (* skip new lines and update line count
       (useful for error location) *)
  | '\n'
      { let _ = new_line lexbuf in tokenize lexbuf }

  (* skip other blanks *)
  | blanks
      { tokenize lexbuf }

  (* Fill here! following the example *)

  | ';'
      { SEMICOLON :: tokenize lexbuf }

  | ','
      { COMMA :: tokenize lexbuf }

  | '.'
      { DOT :: tokenize lexbuf }

  | '<'
      { BRAC :: tokenize lexbuf }

  | '>'
      { KET :: tokenize lexbuf }

  | '"'
      { QUOTES :: tokenize lexbuf }

  | (['a'-'z' 'A'-'Z' '0'-'9' '-' '&' ' ']+ as s)
      { STR(s) :: tokenize lexbuf}

  (* end-of-file : end up with the empty stream *)
  | eof
      { [] }

  (* catch errors *)
  | _ as c
    { let (e: error) = {
          character = c;
          line = lexbuf.lex_curr_p.pos_lnum;
          pos  = lexbuf.lex_curr_p.pos_cnum
                 - lexbuf.lex_curr_p.pos_bol
        } in
      raise (Unexpected_character e)
    }
