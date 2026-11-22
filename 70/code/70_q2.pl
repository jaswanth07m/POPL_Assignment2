:- use_module(library(lists), [append/3]).

% Evaluate integer expression trees; division succeeds only for exact nonzero divisors.
eval_expr(Number, Number) :-
    integer(Number).
eval_expr(+(Left, Right), Value) :-
    eval_expr(Left, LeftValue),
    eval_expr(Right, RightValue),
    Value is LeftValue + RightValue.
eval_expr(-(Left, Right), Value) :-
    eval_expr(Left, LeftValue),
    eval_expr(Right, RightValue),
    Value is LeftValue - RightValue.
eval_expr(*(Left, Right), Value) :-
    eval_expr(Left, LeftValue),
    eval_expr(Right, RightValue),
    Value is LeftValue * RightValue.
eval_expr(/(Left, Right), Value) :-
    eval_expr(Left, LeftValue),
    eval_expr(Right, RightValue),
    RightValue =\= 0,
    0 is LeftValue mod RightValue,
    Value is LeftValue // RightValue.

% Split the ordered inputs recursively and combine valid subexpression trees.
expr_tree([Number], Number, Number).
expr_tree(Numbers, Expr, Value) :-
    append(LeftNumbers, RightNumbers, Numbers),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    expr_tree(LeftNumbers, LeftExpr, _LeftValue),
    expr_tree(RightNumbers, RightExpr, _RightValue),
    ( Expr = +(LeftExpr, RightExpr)
    ; Expr = -(LeftExpr, RightExpr)
    ; Expr = *(LeftExpr, RightExpr)
    ; Expr = /(LeftExpr, RightExpr)
    ),
    eval_expr(Expr, Value).

% Format expression trees using the canonical precedence and associativity rules.
format_expr(Expr, String) :-
    format_expr_context(Expr, 0, left, String).

format_expr_context(Expr, ParentPrecedence, Side, String) :-
    expr_precedence(Expr, Precedence),
    format_expr_body(Expr, Body),
    ( needs_parentheses(Precedence, ParentPrecedence, Side)
    -> string_concat("(", Body, OpenBody),
       string_concat(OpenBody, ")", String)
    ;  String = Body
    ).

expr_precedence(Number, 3) :-
    integer(Number),
    Number >= 0.
expr_precedence(+( _, _), 1).
expr_precedence(-( _, _), 1).
expr_precedence(*( _, _), 2).
expr_precedence(/( _, _), 2).

format_expr_body(Number, String) :-
    integer(Number),
    Number >= 0,
    number_string(Number, String).
format_expr_body(+(Left, Right), String) :-
    format_expr_context(Left, 1, left, LeftString),
    format_expr_context(Right, 1, right, RightString),
    string_concat(LeftString, "+", Prefix),
    string_concat(Prefix, RightString, String).
format_expr_body(-(Left, Right), String) :-
    format_expr_context(Left, 1, left, LeftString),
    format_expr_context(Right, 1, right, RightString),
    string_concat(LeftString, "-", Prefix),
    string_concat(Prefix, RightString, String).
format_expr_body(*(Left, Right), String) :-
    format_expr_context(Left, 2, left, LeftString),
    format_expr_context(Right, 2, right, RightString),
    string_concat(LeftString, "*", Prefix),
    string_concat(Prefix, RightString, String).
format_expr_body(/(Left, Right), String) :-
    format_expr_context(Left, 2, left, LeftString),
    format_expr_context(Right, 2, right, RightString),
    string_concat(LeftString, "/", Prefix),
    string_concat(Prefix, RightString, String).

needs_parentheses(Precedence, ParentPrecedence, left) :-
    Precedence < ParentPrecedence.
needs_parentheses(Precedence, ParentPrecedence, right) :-
    Precedence =< ParentPrecedence.

% Form an equation by splitting the ordered numbers and matching side values.
generate_equation(List, Equation) :-
    append(LeftNumbers, RightNumbers, List),
    LeftNumbers = [_|_],
    RightNumbers = [_|_],
    expr_tree(LeftNumbers, LeftExpr, LeftValue),
    expr_tree(RightNumbers, RightExpr, RightValue),
    LeftValue =:= RightValue,
    format_expr(LeftExpr, LeftString),
    format_expr(RightExpr, RightString),
    string_concat(LeftString, "=", Prefix),
    string_concat(Prefix, RightString, Equation).

% Collect all generated equations, then deduplicate and sort them.
all_equations(List, Equations) :-
    findall(Equation, generate_equation(List, Equation), FoundEquations),
    sort(FoundEquations, Equations).

% Count the unique valid equations returned by all_equations/2.
count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
