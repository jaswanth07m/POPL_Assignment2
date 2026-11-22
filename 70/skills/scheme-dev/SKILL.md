---
name: scheme-dev
description: Develop and review CS F301 Scheme assignment code in Racket 8.x under the assignment's restricted built-in set.
---

# Scheme Development

## Language and conventions

- Use Racket 8.x with `#lang racket/base`.
- Prefer recursive, functional definitions. Pass changing state through function arguments and return new lists instead of mutating data.
- Use small helpers with descriptive names and keep each function focused on one traversal or transformation.
- For nested lists, distinguish atoms, non-empty lists, and empty lists explicitly; an empty list can itself be a nested list.
- Measure list lengths from the original list when the specification requires a pre-transformation length.
- Submitted files contain definitions only: no top-level calls and no output while loading.

## Running and testing

From the repository root, load each assignment module with:

```sh
racket code/70_q3.rkt
racket code/70_q4.rkt
```

These files should load without printing. To exercise functions, use a grader-style test copy with the test calls placed after the definitions, then run `racket <test-copy.rkt>`. Keep calls and test output out of the submitted solution files; the grader appends its own calls.

## Exact allowed built-ins

Use only these forms and procedures from `racket/base`:

- `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, and `cond` with `else`.
- `and`, `or`, `not`, `begin`, and quote written as `'`.
- `cons`, `car`, `cdr`, `list`, and `null?`, `pair?`, `eq?`, `assq`, `assoc`.
- Compositions of `car` and `cdr` up to four selectors, such as `cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, and `cddddr`.
- Arithmetic and comparisons: `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`; also `max`.
- Output: `display` and `newline`.
- S2 additionally allows `read`.

Nothing else from `racket/base` is allowed. In particular, do not use mutation or `set!` and its relatives, vectors, hash tables, strings, or loops such as `do` and `for`. Do not use built-in list helpers including `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, or `list-tail`; write a permitted recursive helper instead.

## Self-review checklist

- Check every recursive call makes progress and has a correct base case.
- Check empty lists, singleton lists, and nested empty lists.
- For nested-list functions, verify whether each operation applies to the outer list, each nested list, or both.
- Confirm list lengths are measured before any transformation when required.
- Check output shape, ordering, exact number of lines, and required newlines.
- Search for every identifier and confirm it is in the allowed built-in list or is a user-defined helper.
- Confirm the file starts with `#lang racket/base` and has no top-level calls or load-time output.

## Common AI failure modes

- Using forbidden `map`, `append`, or `length` instead of writing a helper.
- Recursing into nested lists incorrectly or skipping empty nested lists.
- Counting nested elements instead of only the current list's top-level elements.
- Changing a list before checking the length of its original form.
- Printing while the file is loaded rather than only when the grader calls a function.
- Forgetting the required newline or printing extra prompts and text.
