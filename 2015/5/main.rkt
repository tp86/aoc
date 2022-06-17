#lang racket

; part 1
(define (has-3-vowels? str)
  (regexp-match #px"([aeiou].*){2}[aeiou]" str))

(define (has-double-letter? str)
  (regexp-match #px"(.)\\1" str))

(define (has-naughty-part? str)
  (regexp-match #rx"ab|cd|pq|xy" str))

(define (nice1? str)
  (and (has-3-vowels? str)
       (has-double-letter? str)
       (not (has-naughty-part? str))))

(for/sum ([s (file->lines "input.txt")])
  (let ([n (nice1? s)])
    (if n 1 0)))

; part 2
(define (has-pair? str)
  (regexp-match #px"(..).*\\1" str))

(define (has-one-between? str)
  (regexp-match #px"(.).\\1" str))

(define (nice2? str)
  (and (has-pair? str)
       (has-one-between? str)))

(for/sum ([s (file->lines "input.txt")])
  (let ([n (nice2? s)])
    (if n 1 0)))
