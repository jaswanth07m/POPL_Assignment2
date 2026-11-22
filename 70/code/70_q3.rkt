#lang racket/base

(define (inorder-values tree)
  (let walk ((node tree) (tail '()))
    (if (null? node)
        tail
        (walk (cadr node)
              (cons (car node)
                    (walk (caddr node) tail))))))

(define (print-inorder tree)
  (begin
    (display (inorder-values tree))
    (newline)))

(define (preorder-values tree)
  (let walk ((node tree) (tail '()))
    (if (null? node)
        tail
        (cons (car node)
              (walk (cadr node)
                    (walk (caddr node) tail))))))

(define (postorder-values tree)
  (let walk ((node tree) (tail '()))
    (if (null? node)
        tail
        (walk (cadr node)
              (walk (caddr node)
                    (cons (car node) tail))))))

(define (print-all-traversals tree)
  (begin
    (display (inorder-values tree))
    (newline)
    (display (preorder-values tree))
    (newline)
    (display (postorder-values tree))
    (newline)))

(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1
         (max (tree-height (cadr tree))
              (tree-height (caddr tree))))))

(define (tree-leaf-count tree)
  (if (null? tree)
      0
      (if (and (null? (cadr tree))
               (null? (caddr tree)))
          1
          (+ (tree-leaf-count (cadr tree))
             (tree-leaf-count (caddr tree))))))

(define (print-height-and-leaves tree)
  (begin
    (display (list (tree-height tree) (tree-leaf-count tree)))
    (newline)))
