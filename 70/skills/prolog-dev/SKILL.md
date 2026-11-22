---
name: prolog-dev
description: Develop and review CS F301 Prolog assignment code using SWI-Prolog 9.x and the assignment's restrictions.
---

# Prolog Development

## Language and conventions

- Target SWI-Prolog 9.x.
- Use descriptive predicate and variable names, declarative relationships, and recursion where it fits the problem.
- Add short comments for non-obvious logic and assignment-specific clues.
- Avoid cuts unless they are necessary to express the intended behavior.
- Preserve nondeterminism when backtracking is part of the requirement.

## Running and testing

From the repository root, run the P1 program with:

```sh
swipl -q -f code/70_q1.pl -g main -t halt
```

Run an individual predicate goal with:

```sh
swipl -q -f code/70_q1.pl -g "<goal>" -t halt
```

For example, test a clue with a ground solution by supplying `clue(1, [...])` as the goal. To inspect a result such as a count, the command-line goal may print that result; keep such test output separate from the submitted program's required output.

## Assignment restrictions

- Use only the `lists`, `apply`, `yall`, and `aggregate` libraries.
- Do not use `assert`, `retract`, or global variables such as `b_setval/2` and `nb_setval/2`.
- Do not add initialization directives or call `halt/0` in submitted files.
- Do not print anything beyond the output explicitly required by the assignment.

## Self-review checklist

- Verify every predicate's name and arity against the specification.
- Check expected backtracking, determinism, and duplicate behavior.
- Check that variables are instantiated before arithmetic or comparison operations that require ground values.
- Review empty, singleton, malformed, and boundary inputs as applicable.
- Verify exact output format, including atom versus string representation.
- Verify that imported libraries and predicates are permitted.

## Common AI failure modes

- Hardcoding a puzzle answer instead of deriving it from the constraints.
- Losing or introducing unintended alternatives through incorrect backtracking.
- Using ordinary division where exact integer division is required, or overlooking zero divisors.
- Confusing Prolog atoms, strings, and character lists.
- Counting duplicate proofs as distinct solutions.
- Formatting expression trees with incorrect precedence or associativity parentheses.
