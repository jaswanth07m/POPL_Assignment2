:- use_module(library(lists), [permutation/2]).

% Clue 1: The friend who prefers the AI project does not work in research and is not Dana.
clue(1, [p('Alex', AlexDept, _, AlexProjectPref),
         p('Ben', BenDept, _, BenProject),
         p('Carla', CarlaDept, _, CarlaProject),
         p('Dana', _, _, DanaProject)]) :-
    ( AlexProjectPref = 'AI',
      AlexDept \= research,
      BenProject \= 'AI',
      CarlaProject \= 'AI',
      DanaProject \= 'AI'
    ; BenProject = 'AI',
      BenDept \= research,
      AlexProjectPref \= 'AI',
      CarlaProject \= 'AI',
      DanaProject \= 'AI'
    ; CarlaProject = 'AI',
      CarlaDept \= research,
      AlexProjectPref \= 'AI',
      BenProject \= 'AI',
      DanaProject \= 'AI'
    ).

% Clue 2: Alex's department is not development, and Alex does not prefer C++.
clue(2, [p('Alex', AlexDept, AlexLang, _),
         p('Ben', _, _, _),
         p('Carla', _, _, _),
         p('Dana', _, _, _)]) :-
    AlexDept \= development,
    AlexLang \= 'c++'.

% Clue 3: Anyone assigned to testing must have Python as their favorite language.
clue(3, [p('Alex', AlexDept, AlexLang, _),
         p('Ben', BenDept, BenLang, _),
         p('Carla', CarlaDept, CarlaLang, _),
         p('Dana', DanaDept, DanaLang, _)]) :-
    ( AlexDept \= testing ; AlexLang = python ),
    ( BenDept \= testing ; BenLang = python ),
    ( CarlaDept \= testing ; CarlaLang = python ),
    ( DanaDept \= testing ; DanaLang = python ).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, [p('Alex', _, _, _),
         p('Ben', BenDept, _, BenProject),
         p('Carla', _, _, _),
         p('Dana', _, _, _)]) :-
    BenProject = web,
    BenDept \= testing.

% Clue 5: Anyone whose favorite language is Java works in design.
clue(5, [p('Alex', AlexDept, AlexLang, _),
         p('Ben', BenDept, BenLang, _),
         p('Carla', CarlaDept, CarlaLang, _),
         p('Dana', DanaDept, DanaLang, _)]) :-
    ( AlexLang \= java ; AlexDept = design ),
    ( BenLang \= java ; BenDept = design ),
    ( CarlaLang \= java ; CarlaDept = design ),
    ( DanaLang \= java ; DanaDept = design ).

% Clue 6: Carla is not in development and does not prefer embedded projects.
clue(6, [p('Alex', _, _, _),
         p('Ben', _, _, _),
         p('Carla', CarlaDept, _, CarlaProject),
         p('Dana', _, _, _)]) :-
    CarlaDept \= development,
    CarlaProject \= embedded.

% Clue 7: Dana does not prefer Java and works in research or testing.
clue(7, [p('Alex', _, _, _),
         p('Ben', _, _, _),
         p('Carla', _, _, _),
         p('Dana', DanaDept, DanaLang, _)]) :-
    DanaLang \= java,
    ( DanaDept = research ; DanaDept = testing ).

% Clue 8: Anyone preferring data works in research and does not use JavaScript.
clue(8, [p('Alex', AlexDept, AlexLang, AlexProject),
         p('Ben', BenDept, BenLang, BenProject),
         p('Carla', CarlaDept, CarlaLang, CarlaProject),
         p('Dana', DanaDept, DanaLang, DanaProject)]) :-
    ( AlexProject \= data ; (AlexDept = research, AlexLang \= javascript) ),
    ( BenProject \= data ; (BenDept = research, BenLang \= javascript) ),
    ( CarlaProject \= data ; (CarlaDept = research, CarlaLang \= javascript) ),
    ( DanaProject \= data ; (DanaDept = research, DanaLang \= javascript) ).

% CLUE 9: The friend who prefers the AI project likes Python.
clue(9, [p('Alex', _, AlexLang, AlexProject),
         p('Ben', _, BenLang, BenProject),
         p('Carla', _, CarlaLang, CarlaProject),
         p('Dana', _, DanaLang, DanaProject)]) :-
    ( AlexProject \= 'AI' ; AlexLang = python ),
    ( BenProject \= 'AI' ; BenLang = python ),
    ( CarlaProject \= 'AI' ; CarlaLang = python ),
    ( DanaProject \= 'AI' ; DanaLang = python ).
% Generate permutations of each attribute, then keep assignments satisfying all clues.
solution([p('Alex', AlexDept, AlexLang, AlexProject),
          p('Ben', BenDept, BenLang, BenProject),
          p('Carla', CarlaDept, CarlaLang, CarlaProject),
          p('Dana', DanaDept, DanaLang, DanaProject)]) :-
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]),
    clue(1, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(2, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(3, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(4, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(5, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(6, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(7, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]),
    clue(8, [p('Alex', AlexDept, AlexLang, AlexProject),
             p('Ben', BenDept, BenLang, BenProject),
             p('Carla', CarlaDept, CarlaLang, CarlaProject),
             p('Dana', DanaDept, DanaLang, DanaProject)]).

main :-
    solution([p('Alex', AlexDept, AlexLang, AlexProject),
              p('Ben', BenDept, BenLang, BenProject),
              p('Carla', CarlaDept, CarlaLang, CarlaProject),
              p('Dana', DanaDept, DanaLang, DanaProject)]),
    format('Alex = [~w, ~w, ~w]~n', [AlexDept, AlexLang, AlexProject]),
    format('Ben = [~w, ~w, ~w]~n', [BenDept, BenLang, BenProject]),
    format('Carla = [~w, ~w, ~w]~n', [CarlaDept, CarlaLang, CarlaProject]),
    format('Dana = [~w, ~w, ~w]~n', [DanaDept, DanaLang, DanaProject]).

count_solutions(Active, N) :-
    findall(Solution,
            ( permutation([research, development, design, testing],
                          [AlexDept, BenDept, CarlaDept, DanaDept]),
              permutation([python, java, 'c++', javascript],
                          [AlexLang, BenLang, CarlaLang, DanaLang]),
              permutation(['AI', web, embedded, data],
                          [AlexProject, BenProject, CarlaProject, DanaProject]),
              Solution = [p('Alex', AlexDept, AlexLang, AlexProject),
                          p('Ben', BenDept, BenLang, BenProject),
                          p('Carla', CarlaDept, CarlaLang, CarlaProject),
                          p('Dana', DanaDept, DanaLang, DanaProject)],
              forall(member(ClueNumber, Active),
                     call(clue(ClueNumber, Solution)))
            ),
            Solutions),
    length(Solutions, N).
