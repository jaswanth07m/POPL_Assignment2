# CS F301 – Assignment 2

**Birla Institute of Technology and Science, Pilani – Hyderabad Campus**  
**Course:** CS F301 – Principles of Programming Languages  
**Assignment:** Assignment 2 – Logic and Functional Programming  
**Group ID:** 70

## Group Members

| S. No. | Name | Student ID |
| ------ | ---- | ---------- |
| 1 | Jaswanth Mucherla | 2024A7PS0126H |
| 2 | Sahithya Thallapally | 2024A7PS0002H |

## Assignment Overview

- **P1 – Department Assignment Puzzle:** Solve a constraint-based logic puzzle using Prolog.
- **P2 – Arithmetic Equations:** Generate arithmetic expression trees and evaluate valid equations using Prolog.
- **S1 – Tree Traversals:** Implement binary tree traversals, height, and leaf counting using Racket.
- **S2 – Conditional Insert:** Recursively insert values into nested lists according to each list's original length using Racket.

## Repository Structure

```text
POPL_Assignment2/
├── README.md
└── 70/
    ├── code/
    │   ├── 70_q1.pl
    │   ├── 70_q2.pl
    │   ├── 70_q3.rkt
    │   └── 70_q4.rkt
    ├── tests/
    │   ├── test_p1.pl
    │   ├── test_p2.pl
    │   ├── test_s1.rkt
    │   └── test_s2.rkt
    ├── skills/
    │   ├── prolog-dev/SKILL.md
    │   └── scheme-dev/SKILL.md
    ├── prompts/
    │   ├── P1.md
    │   ├── P2.md
    │   ├── S1.md
    │   └── S2.md
    └── P1_REPORT.md
```

## Technologies

- SWI-Prolog
- Racket with `#lang racket/base`
- Git and GitHub
- AI-assisted development

## Testing

Run these commands from the repository root. The first command enters the group test directory; run the remaining test commands from there:

```bash
cd 70/tests
swipl -f test_p1.pl -g run_tests -t halt
swipl -f test_p2.pl -g run_tests -t halt
racket test_s1.rkt
racket test_s2.rkt
```

## Running the Solution Files

After the test commands above, the shell is in `70/tests`. Return to the group folder with `cd ..`, then run the individual files:

```bash
cd ..
swipl -q -f code/70_q1.pl -g main -t halt
swipl -q -f code/70_q2.pl -t halt
racket code/70_q3.rkt
racket code/70_q4.rkt
```

These are program invocation commands, not claims that every file produces visible output. For example, loading a definitions-only file may exit without printing anything.

## Repository

[github.com/jaswanth07m/POPL_Assignment2](https://github.com/jaswanth07m/POPL_Assignment2)
