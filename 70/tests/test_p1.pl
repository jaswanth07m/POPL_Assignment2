:- consult('../code/70_q1.pl').

% This complete assignment is the shared positive fixture for clues 1 through 9.
sample_solution([p('Alex', design, java, embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', testing, python, 'AI'),
                 p('Dana', research, 'c++', data)]).

% Clue 1 accepts an AI-preferring friend outside research and not Dana.
clue_1_positive :-
    sample_solution(Solution),
    clue(1, Solution).

% Clue 1 rejects an assignment where the AI-preferring friend works in research.
clue_1_negative :-
    \+ clue(1, [p('Alex', design, java, embedded),
                p('Ben', development, javascript, web),
                p('Carla', research, python, 'AI'),
                p('Dana', testing, 'c++', data)]).

% Clue 2 accepts Alex outside development and with a language other than C++.
clue_2_positive :-
    sample_solution(Solution),
    clue(2, Solution).

% Clue 2 rejects Alex assigned to development and C++.
clue_2_negative :-
    \+ clue(2, [p('Alex', development, 'c++', embedded),
                p('Ben', design, java, web),
                p('Carla', testing, python, 'AI'),
                p('Dana', research, javascript, data)]).

% Clue 3 accepts a testing assignment paired with Python.
clue_3_positive :-
    sample_solution(Solution),
    clue(3, Solution).

% Clue 3 rejects a testing assignment paired with C++.
clue_3_negative :-
    \+ clue(3, [p('Alex', design, java, embedded),
                p('Ben', development, javascript, web),
                p('Carla', testing, 'c++', 'AI'),
                p('Dana', research, python, data)]).

% Clue 4 accepts Ben preferring web and working outside testing.
clue_4_positive :-
    sample_solution(Solution),
    clue(4, Solution).

% Clue 4 rejects Ben working in testing, even though he prefers web.
clue_4_negative :-
    \+ clue(4, [p('Alex', design, java, embedded),
                p('Ben', testing, javascript, web),
                p('Carla', development, python, 'AI'),
                p('Dana', research, 'c++', data)]).

% Clue 5 accepts Java paired with the design department.
clue_5_positive :-
    sample_solution(Solution),
    clue(5, Solution).

% Clue 5 rejects Java paired with a department other than design.
clue_5_negative :-
    \+ clue(5, [p('Alex', development, java, embedded),
                p('Ben', design, javascript, web),
                p('Carla', testing, python, 'AI'),
                p('Dana', research, 'c++', data)]).

% Clue 6 accepts Carla outside development with a non-embedded project.
clue_6_positive :-
    sample_solution(Solution),
    clue(6, Solution).

% Clue 6 rejects Carla preferring embedded projects.
clue_6_negative :-
    \+ clue(6, [p('Alex', design, java, 'AI'),
                p('Ben', development, javascript, web),
                p('Carla', testing, python, embedded),
                p('Dana', research, 'c++', data)]).

% Clue 7 accepts Dana in research or testing with a non-Java language.
clue_7_positive :-
    sample_solution(Solution),
    clue(7, Solution).

% Clue 7 rejects Dana working outside research and testing.
clue_7_negative :-
    \+ clue(7, [p('Alex', design, java, embedded),
                p('Ben', research, javascript, web),
                p('Carla', testing, python, 'AI'),
                p('Dana', development, 'c++', data)]).

% Clue 8 accepts data in research with a language other than JavaScript.
clue_8_positive :-
    sample_solution(Solution),
    clue(8, Solution).

% Clue 8 rejects data paired with JavaScript.
clue_8_negative :-
    \+ clue(8, [p('Alex', design, java, embedded),
                p('Ben', development, 'c++', web),
                p('Carla', testing, python, 'AI'),
                p('Dana', research, javascript, data)]).

% Clue 9 accepts AI paired with Python.
clue_9_positive :-
    sample_solution(Solution),
    clue(9, Solution).

% Clue 9 rejects AI paired with a language other than Python.
clue_9_negative :-
    \+ clue(9, [p('Alex', design, java, embedded),
                p('Ben', development, javascript, web),
                p('Carla', testing, 'c++', 'AI'),
                p('Dana', research, python, data)]).

% The generator returns a correctly shaped assignment satisfying clues 1 through 8.
solution_generates_valid_assignment :-
    solution([p('Alex', AlexDept, AlexLang, AlexProject),
              p('Ben', BenDept, BenLang, BenProject),
              p('Carla', CarlaDept, CarlaLang, CarlaProject),
              p('Dana', DanaDept, DanaLang, DanaProject)]),
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]),
    Solution = [p('Alex', AlexDept, AlexLang, AlexProject),
                p('Ben', BenDept, BenLang, BenProject),
                p('Carla', CarlaDept, CarlaLang, CarlaProject),
                p('Dana', DanaDept, DanaLang, DanaProject)],
    clue(1, Solution),
    clue(2, Solution),
    clue(3, Solution),
    clue(4, Solution),
    clue(5, Solution),
    clue(6, Solution),
    clue(7, Solution),
    clue(8, Solution).

% Clues 1 through 8 have the specified three assignments.
count_clues_1_through_8 :-
    count_solutions([1,2,3,4,5,6,7,8], N),
    N =:= 3.

% Adding clue 9 leaves exactly one assignment.
count_clues_1_through_9 :-
    count_solutions([1,2,3,4,5,6,7,8,9], N),
    N =:= 1.

% An empty active-clue list counts every permutation of the three attributes.
count_empty_active_list :-
    count_solutions([], N),
    N =:= 13824.

% main/0 must produce exactly four correctly formatted lines for its first solution.
main_has_exact_output_format :-
    once(solution([p('Alex', AlexDept, AlexLang, AlexProject),
                   p('Ben', BenDept, BenLang, BenProject),
                   p('Carla', CarlaDept, CarlaLang, CarlaProject),
                   p('Dana', DanaDept, DanaLang, DanaProject)])),
    format(string(Expected),
           'Alex = [~w, ~w, ~w]~nBen = [~w, ~w, ~w]~nCarla = [~w, ~w, ~w]~nDana = [~w, ~w, ~w]~n',
           [AlexDept, AlexLang, AlexProject,
            BenDept, BenLang, BenProject,
            CarlaDept, CarlaLang, CarlaProject,
            DanaDept, DanaLang, DanaProject]),
    with_output_to(string(Actual), main),
    Actual = Expected.

% Report each test and raise an error immediately if a test has the wrong result.
check_success(Name, Goal) :-
    ( once(call(Goal))
    -> format('PASS: ~w~n', [Name])
    ;  throw(error(test_failed(Name), _))
    ).

check_failure(Name, Goal) :-
    ( \+ call(Goal)
    -> format('PASS: ~w~n', [Name])
    ;  throw(error(test_unexpectedly_succeeded(Name), _))
    ).

% Run from the tests directory with: swipl -q -f test_p1.pl -g run_p1_tests -t halt
run_p1_tests :-
    check_success('clue 1 positive', clue_1_positive),
    check_failure('clue 1 negative', clue_1_negative),
    check_success('clue 2 positive', clue_2_positive),
    check_failure('clue 2 negative', clue_2_negative),
    check_success('clue 3 positive', clue_3_positive),
    check_failure('clue 3 negative', clue_3_negative),
    check_success('clue 4 positive', clue_4_positive),
    check_failure('clue 4 negative', clue_4_negative),
    check_success('clue 5 positive', clue_5_positive),
    check_failure('clue 5 negative', clue_5_negative),
    check_success('clue 6 positive', clue_6_positive),
    check_failure('clue 6 negative', clue_6_negative),
    check_success('clue 7 positive', clue_7_positive),
    check_failure('clue 7 negative', clue_7_negative),
    check_success('clue 8 positive', clue_8_positive),
    check_failure('clue 8 negative', clue_8_negative),
    check_success('clue 9 positive', clue_9_positive),
    check_failure('clue 9 negative', clue_9_negative),
    check_success('solution generates valid assignment', solution_generates_valid_assignment),
    check_success('count clues 1 through 8', count_clues_1_through_8),
    check_success('count clues 1 through 9', count_clues_1_through_9),
    check_success('count empty active list', count_empty_active_list),
    check_success('main output format', main_has_exact_output_format).

:- use_module(library(plunit)).
:- begin_tests(p1).

test(clue_1_positive) :- user:clue_1_positive.
test(clue_1_negative) :- user:clue_1_negative.
test(clue_2_positive) :- user:clue_2_positive.
test(clue_2_negative) :- user:clue_2_negative.
test(clue_3_positive) :- user:clue_3_positive.
test(clue_3_negative) :- user:clue_3_negative.
test(clue_4_positive) :- user:clue_4_positive.
test(clue_4_negative) :- user:clue_4_negative.
test(clue_5_positive) :- user:clue_5_positive.
test(clue_5_negative) :- user:clue_5_negative.
test(clue_6_positive) :- user:clue_6_positive.
test(clue_6_negative) :- user:clue_6_negative.
test(clue_7_positive) :- user:clue_7_positive.
test(clue_7_negative) :- user:clue_7_negative.
test(clue_8_positive) :- user:clue_8_positive.
test(clue_8_negative) :- user:clue_8_negative.
test(clue_9_positive) :- user:clue_9_positive.
test(clue_9_negative) :- user:clue_9_negative.
test(solution_generates_valid_assignment) :- user:solution_generates_valid_assignment.
test(count_clues_1_through_8) :- user:count_clues_1_through_8.
test(count_clues_1_through_9) :- user:count_clues_1_through_9.
test(count_empty_active_list) :- user:count_empty_active_list.
test(main_has_exact_output_format) :- user:main_has_exact_output_format.

:- end_tests(p1).
