#lang racket/base

(require rackunit
         racket/runtime-path)

;; The solution module does not export its definitions; use its namespace to
;; exercise the existing implementation without changing 70/code/70_q3.rkt.
(define-runtime-path implementation-module "../code/70_q3.rkt")
(dynamic-require implementation-module #f)
(define implementation-namespace
  (module->namespace implementation-module))

(define (call-implementation function tree)
  (parameterize ([current-namespace implementation-namespace])
    (eval (list function (list 'quote tree)))))

(define t1
  '(4 (2 (1 () ()) (3 () ()))
      (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define empty-tree '())
(define single-node '(9 () ()))
(define deeper-tree
  '(1 (2 (3 () ()) ()) (4 () (5 (6 () ()) ()))))

;; Inorder traversal follows left subtree, node, right subtree.
(check-equal? (call-implementation 'inorder-values t1)
              '(1 2 3 4 5 6 7))
(check-equal? (call-implementation 'inorder-values t2)
              '(1 2 3))
(check-equal? (call-implementation 'inorder-values t3)
              '(b a c))

;; Preorder traversal follows node, left subtree, right subtree.
(check-equal? (call-implementation 'preorder-values t1)
              '(4 2 1 3 6 5 7))
(check-equal? (call-implementation 'preorder-values t2)
              '(1 2 3))
(check-equal? (call-implementation 'preorder-values t3)
              '(a b c))

;; Postorder traversal follows left subtree, right subtree, node.
(check-equal? (call-implementation 'postorder-values t1)
              '(1 3 2 5 7 6 4))
(check-equal? (call-implementation 'postorder-values t2)
              '(3 2 1))
(check-equal? (call-implementation 'postorder-values t3)
              '(b c a))

;; The assignment requires all traversals of an empty tree to be empty lists.
(check-equal? (call-implementation 'inorder-values empty-tree) '())
(check-equal? (call-implementation 'preorder-values empty-tree) '())
(check-equal? (call-implementation 'postorder-values empty-tree) '())

;; Height and leaf count for the three assignment trees.
(check-equal? (call-implementation 'tree-height t1) 3)
(check-equal? (call-implementation 'tree-leaf-count t1) 4)
(check-equal? (call-implementation 'tree-height t2) 3)
(check-equal? (call-implementation 'tree-leaf-count t2) 1)
(check-equal? (call-implementation 'tree-height t3) 2)
(check-equal? (call-implementation 'tree-leaf-count t3) 2)

;; The empty tree has height zero and no leaves.
(check-equal? (call-implementation 'tree-height empty-tree) 0)
(check-equal? (call-implementation 'tree-leaf-count empty-tree) 0)

;; A single node has height one and is one leaf.
(check-equal? (call-implementation 'tree-height single-node) 1)
(check-equal? (call-implementation 'tree-leaf-count single-node) 1)

;; A deeper, asymmetric tree checks max-height and recursive leaf accumulation.
(check-equal? (call-implementation 'tree-height deeper-tree) 4)
(check-equal? (call-implementation 'tree-leaf-count deeper-tree) 2)
