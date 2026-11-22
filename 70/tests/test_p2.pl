:- use_module(library(plunit)).
:- consult('../code/70_q2.pl').

:- begin_tests(p2).

% eval_expr/2 adds integer leaves recursively.
test(eval_addition) :-
    user:eval_expr(+(4, 5), 9).

% eval_expr/2 subtracts integer leaves recursively.
test(eval_subtraction) :-
    user:eval_expr(-(4, 9), -5).

% eval_expr/2 multiplies integer leaves recursively.
test(eval_multiplication) :-
    user:eval_expr(*(4, 5), 20).

% eval_expr/2 accepts a division with an exact integer quotient.
test(eval_exact_division) :-
    user:eval_expr(/(12, 3), 4).

% Division with a remainder must fail.
test(eval_inexact_division, [fail]) :-
    user:eval_expr(/(7, 2), _).

% A zero divisor must fail without raising an arithmetic exception.
test(eval_division_by_zero, [fail]) :-
    user:eval_expr(/(7, 0), _).

% A singleton number is its own expression tree and value.
test(expr_tree_single_number) :-
    user:expr_tree([5], 5, 5).

% Two input numbers combine in their original order.
test(expr_tree_two_numbers) :-
    user:expr_tree([2, 3], +(2, 3), 5).

% findall/3 observes multiple distinct expression trees through backtracking.
test(expr_tree_backtracks_over_trees) :-
    findall(Expr, user:expr_tree([1, 2, 3], Expr, _), Trees),
    sort(Trees, UniqueTrees),
    length(UniqueTrees, Count),
    Count > 1.

% Expression-tree generation accepts exact division.
test(expr_tree_exact_division) :-
    user:expr_tree([8, 4], /(8, 4), 2).

% Expression-tree generation rejects inexact division.
test(expr_tree_rejects_inexact_division, [fail]) :-
    user:expr_tree([7, 2], /(7, 2), _).

% Expression-tree generation rejects division by zero.
test(expr_tree_rejects_zero_division, [fail]) :-
    user:expr_tree([7, 0], /(7, 0), _).

% Lower-precedence left operands are parenthesized.
test(format_lower_precedence_left_operand) :-
    user:format_expr(*(+(4, 2), 3), "(4+2)*3").

% A higher-precedence right operand needs no parentheses.
test(format_higher_precedence_right_operand) :-
    user:format_expr(+(4, *(2, 3)), "4+2*3").

% A left-nested equal-precedence multiplication/division tree is unparenthesized.
test(format_left_associative_multiplication_division) :-
    user:format_expr(*(/(8, 4), 2), "8/4*2").

% An equal-precedence right operand is parenthesized to preserve the tree.
test(format_equal_precedence_right_operand) :-
    user:format_expr(/(8, *(4, 2)), "8/(4*2)").

% Left-nested subtraction prints without parentheses.
test(format_left_nested_subtraction) :-
    user:format_expr(-(-(1, 2), 3), "1-2-3").

% Right-nested subtraction prints with parentheses.
test(format_right_nested_subtraction) :-
    user:format_expr(-(1, -(2, 3)), "1-(2-3)").

% Right-nested addition prints with parentheses to preserve the expression tree.
test(format_right_nested_addition) :-
    user:format_expr(+(1, +(2, 3)), "1+(2+3)").

% The generator can produce one of the required valid equations.
test(generate_known_equation) :-
    once(user:generate_equation([4, 2, 5, 3], "4*2=5+3")).

% No equation exists for this input order.
test(generate_impossible_list, [fail]) :-
    user:generate_equation([2, 3, 4], _).

% Lists with no input number cannot be split into two non-empty sides.
test(generate_empty_list, [fail]) :-
    user:generate_equation([], _).

% A single number cannot be split into two non-empty sides.
test(generate_singleton_list, [fail]) :-
    user:generate_equation([4], _).

% all_equations/2 returns every required string in sort/2 order.
test(all_equations_required_seven) :-
    user:all_equations(
        [4, 2, 5, 3],
        ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
         "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]).

% An impossible input produces the empty equation list.
test(all_equations_empty_result) :-
    user:all_equations([2, 3, 4], []).

% The three-number multiplication example returns one SWI-Prolog string.
test(all_equations_single_result) :-
    user:all_equations([2, 4, 8], ["2*4=8"]).

% The known four-number input has seven distinct equations.
test(count_equations_seven) :-
    user:count_equations([4, 2, 5, 3], 7).

% The impossible input has no equations.
test(count_equations_zero) :-
    user:count_equations([2, 3, 4], 0).

% The multiplication example has one equation.
test(count_equations_one) :-
    user:count_equations([2, 4, 8], 1).

:- end_tests(p2).

% Run from the tests directory with: swipl -q -f test_p2.pl -g run_tests -t halt
