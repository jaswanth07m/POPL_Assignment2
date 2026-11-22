#lang racket/base

(require rackunit
         racket/runtime-path)

;; Access private definitions from the existing implementation without editing it.
(define-runtime-path implementation-module "../code/70_q4.rkt")
(dynamic-require implementation-module #f)
(define implementation-namespace
  (module->namespace implementation-module))

(define (call-implementation expression)
  (parameterize ([current-namespace implementation-namespace])
    (eval expression)))

(define (call-my-length lst)
  (call-implementation (list 'my-length (list 'quote lst))))

(define (call-my-map proc-expression lst)
  (call-implementation
   (list 'my-map proc-expression (list 'quote lst))))

(define (call-make-inserter x len-ok-expression lst)
  (call-implementation
   (list (list 'make-inserter (list 'quote x) len-ok-expression)
         (list 'quote lst))))

(define (call-insert-if-short x lst n)
  (call-implementation
   (list 'insert-if-short (list 'quote x) (list 'quote lst) n)))

(define (make-ones count)
  (let build ((remaining count) (result '()))
    (if (= remaining 0)
        result
        (build (- remaining 1) (cons 1 result)))))

(define (all-equal-to? lst value)
  (if (null? lst)
      #t
      (and (= (car lst) value)
           (all-equal-to? (cdr lst) value))))

(define (make-nested-list depth value)
  (if (= depth 0)
      value
      (make-nested-list (- depth 1) (list value))))

(define (make-inserted-nested-list depth value)
  (if (= depth 0)
      value
      (list 'x (make-inserted-nested-list (- depth 1) value))))

;; my-length counts only the current list's elements.
(check-equal? (call-my-length '()) 0)
(check-equal? (call-my-length '(1 2 3)) 3)
(check-equal? (call-my-length '((1 2) (3) 4)) 3)

;; my-length handles the assignment's 10,000-element stress size.
(define long-list (make-ones 10000))
(check-equal? (call-my-length long-list) 10000)

;; my-map preserves order, handles the empty list, and transforms each top-level element.
(check-equal? (call-my-map '(lambda (x) (+ x 1)) '()) '())
(check-equal? (call-my-map '(lambda (x) x) '(1 2 3)) '(1 2 3))
(check-equal? (call-my-map '(lambda (x) (+ x 1)) '(1 2 3)) '(2 3 4))
(check-equal? (call-my-map '(lambda (x) (cons 0 x)) '((1 2) (3)))
              '((0 1 2) (0 3)))

;; Mapping over 10,000 elements transforms every element and preserves list size.
(define long-mapped-list
  (call-my-map '(lambda (x) (+ x 1)) long-list))
(check-equal? (call-my-length long-mapped-list) 10000)
(check-true (all-equal-to? long-mapped-list 2))

;; make-inserter processes nested lists and empty nested lists by original length.
(define nested-input '((1 2) () (3 4 5)))
(check-equal?
 (call-make-inserter 'x '(lambda (len) (< len 3)) nested-input)
 '((x 1 2) (x) (3 4 5)))

;; The original input remains unchanged after make-inserter returns a new list.
(check-equal? nested-input '((1 2) () (3 4 5)))

;; make-inserter checks the outer list as well as every nested list.
(check-equal?
 (call-make-inserter 'x '(lambda (len) (< len 4)) nested-input)
 '(x (x 1 2) (x) (x 3 4 5)))

;; insert-if-short inserts for shorter lists, but not for equal or longer lists.
(check-equal? (call-insert-if-short 'x '(a b) 3) '(x a b))
(check-equal? (call-insert-if-short 'x '(a b c) 3) '(a b c))
(check-equal? (call-insert-if-short 'x '(a b c d) 3) '(a b c d))

;; A nested length-two list is checked before its insertion grows it to length three.
(check-equal? (call-insert-if-short 'x '((a b)) 3) '(x (x a b)))

;; The first supplied S2 example checks the outer list and each child list.
(check-equal?
 (call-insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
 '((42 1 2) (3 4 5) (42 6) (42)))

;; The second supplied example checks nested sublists and an empty inner list.
(check-equal?
 (call-insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
 '((0 (0 1) 2) (0 3) (0 (4 5 6) (0))))

;; An empty outer list becomes a singleton only when its length is below n.
(check-equal? (call-insert-if-short 7 '() 3) '(7))
(check-equal? (call-insert-if-short 7 '() 0) '())

;; Nested traversal reaches every list at depth 100.
(define deep-list (make-nested-list 100 'leaf))
(check-equal?
 (call-insert-if-short 'x deep-list 2)
 (make-inserted-nested-list 100 'leaf))

;; insert-if-short handles a 10,000-element outer list without changing child atoms.
(define long-inserted-list
  (call-insert-if-short 'x long-list 10001))
(check-equal? (car long-inserted-list) 'x)
(check-equal? (call-my-length long-inserted-list) 10001)
(check-equal? (call-my-length (cdr long-inserted-list)) 10000)
(check-true (all-equal-to? (cdr long-inserted-list) 1))
