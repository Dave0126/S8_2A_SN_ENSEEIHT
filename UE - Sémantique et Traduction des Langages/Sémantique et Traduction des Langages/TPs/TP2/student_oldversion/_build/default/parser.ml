
module MenhirBasics = struct
  
  exception Error
  
  let _eRR : exn =
    Error
  
  type token = 
    | WhileToken
    | UMinusToken
    | TrueToken
    | ThenToken
    | StarToken
    | SlashToken
    | SequenceToken
    | RightParenthesisToken
    | RefToken
    | RecToken
    | PlusToken
    | OrToken
    | NumberToken of (
# 6 "parser.mly"
       (int)
# 26 "parser.ml"
  )
    | NotToken
    | MinusToken
    | LetToken
    | LesserToken
    | LesserEqualToken
    | LeftParenthesisToken
    | InToken
    | IfToken
    | IdentToken of (
# 7 "parser.mly"
       (string)
# 39 "parser.ml"
  )
    | GreaterToken
    | GreaterEqualToken
    | FunctionToken
    | FalseToken
    | EqualToken
    | ElseToken
    | EOF
    | DoneToken
    | DoToken
    | DifferentToken
    | DerefToken
    | BodyToken
    | AssignToken
    | AndToken
  
end

include MenhirBasics

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState69
  | MenhirState65
  | MenhirState60
  | MenhirState57
  | MenhirState54
  | MenhirState52
  | MenhirState49
  | MenhirState47
  | MenhirState45
  | MenhirState43
  | MenhirState41
  | MenhirState39
  | MenhirState37
  | MenhirState35
  | MenhirState33
  | MenhirState31
  | MenhirState29
  | MenhirState27
  | MenhirState25
  | MenhirState23
  | MenhirState20
  | MenhirState18
  | MenhirState14
  | MenhirState13
  | MenhirState12
  | MenhirState9
  | MenhirState8
  | MenhirState6
  | MenhirState3
  | MenhirState1
  | MenhirState0

# 1 "parser.mly"
  
open Ast

# 104 "parser.ml"

[@@@ocaml.warning "-4-39"]

let rec _menhir_run23 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState23 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState23 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState23
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState23

and _menhir_run25 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState25 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState25
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState25

and _menhir_run27 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState27 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState27
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState27

and _menhir_run29 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState29 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState29
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState29

and _menhir_run31 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState31 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState31
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31

and _menhir_run33 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState33 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState33
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState33

and _menhir_run35 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState35 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState35
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState35

and _menhir_run37 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState37
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37

and _menhir_run39 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState39 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState39
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState39

and _menhir_run41 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState41 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState41 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState41
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState41

and _menhir_run43 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState43 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState43
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState43

and _menhir_run45 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState45 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState45
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState45

and _menhir_run49 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState49 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState49
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState49

and _menhir_run47 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail * _menhir_state * (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState47 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState47 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState47
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState47

and _menhir_goto_expr :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> (Ast.ast) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (e : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 99 "parser.mly"
                                                                     (ReadNode e)
# 651 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), (n : (
# 7 "parser.mly"
       (string)
# 692 "parser.ml"
            ))), _, (e : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 88 "parser.mly"
                                                                     (FunctionNode (n,e))
# 697 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState23 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 111 "parser.mly"
                                                                     (BinaryNode (Multiply,e1,e2))
# 713 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState25 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 112 "parser.mly"
                                                                     (BinaryNode (Divide,e1,e2))
# 723 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e : (Ast.ast))), _, (p : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 93 "parser.mly"
                                                                     (SequenceNode(e,p))
# 765 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState29 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | GreaterEqualToken | GreaterToken | InToken | LesserEqualToken | LesserToken | MinusToken | OrToken | PlusToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 109 "parser.mly"
                                                                     (BinaryNode (Add,e1,e2))
# 789 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState31 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 108 "parser.mly"
                                                                     (BinaryNode (Or,e1,e2))
# 833 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | GreaterEqualToken | GreaterToken | InToken | LesserEqualToken | LesserToken | MinusToken | OrToken | PlusToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 110 "parser.mly"
                                                                     (BinaryNode (Substract,e1,e2))
# 857 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 103 "parser.mly"
                                                                     (BinaryNode (Lesser,e1,e2))
# 885 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 105 "parser.mly"
                                                                     (BinaryNode (LesserEqual,e1,e2))
# 913 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState39 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 104 "parser.mly"
                                                                     (BinaryNode (Greater,e1,e2))
# 941 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 106 "parser.mly"
                                                                     (BinaryNode (GreaterEqual,e1,e2))
# 969 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 101 "parser.mly"
                                                                     (BinaryNode (Equal,e1,e2))
# 1005 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 102 "parser.mly"
                                                                     (BinaryNode (Different,e1,e2))
# 1041 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState47 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken | DoToken | DoneToken | EOF | ElseToken | InToken | OrToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 107 "parser.mly"
                                                                     (BinaryNode (And,e1,e2))
# 1083 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | SequenceToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s, (i : (Ast.ast))), _, (e : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 100 "parser.mly"
                                                                     (WriteNode(i,e))
# 1129 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState52 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState52
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | ElseToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState54 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState54
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState54)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState54 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), _, (c : (Ast.ast))), _, (t : (Ast.ast))), _, (e : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 91 "parser.mly"
                                                                     (IfthenelseNode (c,t,e))
# 1329 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | RightParenthesisToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState57 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState57
            | AndToken | AssignToken | DifferentToken | DoToken | DoneToken | EOF | ElseToken | EqualToken | GreaterEqualToken | GreaterToken | InToken | LesserEqualToken | LesserToken | OrToken | PlusToken | RightParenthesisToken | SequenceToken | SlashToken | StarToken | ThenToken ->
                let _menhir_stack = Obj.magic _menhir_stack in
                let ((_menhir_stack, _menhir_s), _, (e : (Ast.ast))) = _menhir_stack in
                let _v : (Ast.ast) = 
# 95 "parser.mly"
                                                                     (e)
# 1404 "parser.ml"
                 in
                _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState57)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState57 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (f : (Ast.ast))), _, (p : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 94 "parser.mly"
                                                                     (CallNode (f,p))
# 1462 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | InToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState60 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState60 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState60
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState60)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState60 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), (n : (
# 7 "parser.mly"
       (string)
# 1585 "parser.ml"
            ))), _, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 89 "parser.mly"
                                                                     (LetNode (n,e1,e2))
# 1590 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (e : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 96 "parser.mly"
                                                                     (UnaryNode (Opposite,e))
# 1606 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (e : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 97 "parser.mly"
                                                                     (UnaryNode (Negation,e))
# 1616 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | InToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState65 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState65
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState65)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | DoToken | DoneToken | EOF | ElseToken | InToken | RightParenthesisToken | ThenToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((((_menhir_stack, _menhir_s), (n : (
# 7 "parser.mly"
       (string)
# 1733 "parser.ml"
            ))), _, (e1 : (Ast.ast))), _, (e2 : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 90 "parser.mly"
                                                                     (LetrecNode (n,e1,e2))
# 1738 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _, (e : (Ast.ast))) = _menhir_stack in
        let _v : (Ast.ast) = 
# 98 "parser.mly"
                                                                     (RefNode e)
# 1754 "parser.ml"
         in
        _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | DoToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState69 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState69
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState69)
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState69 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | DoneToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (((_menhir_stack, _menhir_s), _, (c : (Ast.ast))), _, (b : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 92 "parser.mly"
                                                          (WhileNode(c,b))
# 1852 "parser.ml"
             in
            _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | AndToken ->
            _menhir_run47 _menhir_env (Obj.magic _menhir_stack)
        | AssignToken ->
            _menhir_run49 _menhir_env (Obj.magic _menhir_stack)
        | DifferentToken ->
            _menhir_run45 _menhir_env (Obj.magic _menhir_stack)
        | EOF ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, (a : (Ast.ast))) = _menhir_stack in
            let _v : (Ast.ast) = 
# 85 "parser.mly"
                      (a)
# 1901 "parser.ml"
             in
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_1 : (Ast.ast)) = _v in
            Obj.magic _1
        | EqualToken ->
            _menhir_run43 _menhir_env (Obj.magic _menhir_stack)
        | GreaterEqualToken ->
            _menhir_run41 _menhir_env (Obj.magic _menhir_stack)
        | GreaterToken ->
            _menhir_run39 _menhir_env (Obj.magic _menhir_stack)
        | LesserEqualToken ->
            _menhir_run37 _menhir_env (Obj.magic _menhir_stack)
        | LesserToken ->
            _menhir_run35 _menhir_env (Obj.magic _menhir_stack)
        | MinusToken ->
            _menhir_run33 _menhir_env (Obj.magic _menhir_stack)
        | OrToken ->
            _menhir_run31 _menhir_env (Obj.magic _menhir_stack)
        | PlusToken ->
            _menhir_run29 _menhir_env (Obj.magic _menhir_stack)
        | SequenceToken ->
            _menhir_run27 _menhir_env (Obj.magic _menhir_stack)
        | SlashToken ->
            _menhir_run25 _menhir_env (Obj.magic _menhir_stack)
        | StarToken ->
            _menhir_run23 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_errorcase :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState69 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState65 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState60 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState57 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState54 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState52 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState49 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState47 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState45 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState43 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState41 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState39 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState37 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState35 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState33 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState31 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState29 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState27 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState25 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState23 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState20 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState18 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState14 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState13 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState12 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState9 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState8 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState6 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState3 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState1 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s
    | MenhirState0 ->
        let _menhir_stack = Obj.magic _menhir_stack in
        raise _eRR

and _menhir_run1 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState1 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState1
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState1

and _menhir_run2 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.ast) = 
# 115 "parser.mly"
                                                                     (TrueNode)
# 2109 "parser.ml"
     in
    _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run3 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState3
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3

and _menhir_run4 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IdentToken _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EqualToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState6 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState6
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState6)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run7 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 6 "parser.mly"
       (int)
# 2217 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (i : (
# 6 "parser.mly"
       (int)
# 2225 "parser.ml"
    )) = _v in
    let _v : (Ast.ast) = 
# 114 "parser.mly"
                                                                     (IntegerNode i)
# 2230 "parser.ml"
     in
    _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run8 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState8 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState8
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState8

and _menhir_run9 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState9 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState9 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState9
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState9

and _menhir_run10 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IdentToken _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | EqualToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState12 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState12
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState12)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run13 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState13 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState13
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState13

and _menhir_run14 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState14 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState14
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState14

and _menhir_run15 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 7 "parser.mly"
       (string)
# 2455 "parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let (n : (
# 7 "parser.mly"
       (string)
# 2463 "parser.ml"
    )) = _v in
    let _v : (Ast.ast) = 
# 113 "parser.mly"
                                                                     (AccessNode n)
# 2468 "parser.ml"
     in
    _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run16 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IdentToken _v ->
        let _menhir_stack = Obj.magic _menhir_stack in
        let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        (match _tok with
        | BodyToken ->
            let _menhir_stack = Obj.magic _menhir_stack in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            (match _tok with
            | DerefToken ->
                _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | FalseToken ->
                _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | FunctionToken ->
                _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | IdentToken _v ->
                _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | IfToken ->
                _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | LeftParenthesisToken ->
                _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | LetToken ->
                _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | MinusToken ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | NotToken ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | NumberToken _v ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState18 _v
            | RecToken ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | RefToken ->
                _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | TrueToken ->
                _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | WhileToken ->
                _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState18
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState18)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let _menhir_stack = Obj.magic _menhir_stack in
            let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let _menhir_stack = Obj.magic _menhir_stack in
        let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s

and _menhir_run19 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _menhir_stack = Obj.magic _menhir_stack in
    let _v : (Ast.ast) = 
# 116 "parser.mly"
                                                                     (FalseNode)
# 2541 "parser.ml"
     in
    _menhir_goto_expr _menhir_env _menhir_stack _menhir_s _v

and _menhir_run20 :  'ttv_tail 'ttv_return. _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState20 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState20
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState20

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.ast) =
  fun lexer lexbuf ->
    let _menhir_env = {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = Obj.magic ();
      _menhir_error = false;
    } in
    Obj.magic (let _menhir_stack = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DerefToken ->
        _menhir_run20 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | FalseToken ->
        _menhir_run19 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | FunctionToken ->
        _menhir_run16 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | IdentToken _v ->
        _menhir_run15 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | IfToken ->
        _menhir_run14 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LeftParenthesisToken ->
        _menhir_run13 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | LetToken ->
        _menhir_run10 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | MinusToken ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | NotToken ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | NumberToken _v ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState0 _v
    | RecToken ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | RefToken ->
        _menhir_run3 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | TrueToken ->
        _menhir_run2 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | WhileToken ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0)
