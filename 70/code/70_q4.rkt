#lang racket/base

(define (my-length lst)
  (if (null? lst)
      0
      (+ 1 (my-length (cdr lst)))))

(define (my-map proc lst)
  (if (null? lst)
      '()
      (cons (proc (car lst))
            (my-map proc (cdr lst)))))

(define (make-inserter x len-ok?)
  (letrec ((walk
            (lambda (lst)
              (let ((original-length (my-length lst)))
                (let ((processed
                       (my-map
                        (lambda (item)
                          (if (or (pair? item) (null? item))
                              (walk item)
                              item))
                        lst)))
                  (if (len-ok? original-length)
                      (cons x processed)
                      processed))))))
    (lambda (lst) (walk lst))))

(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
