#lang racket

(define (build-matcher rx)
  (λ (s)
    (regexp-match? rx s)))

(define (nice? matchers str)
  (for/and ([f matchers])
    (f str)))

(define (solve matchers)
  (for/sum ([s (file->lines "input.txt")])
    (let ([n (nice? matchers s)])
      (if n 1 0))))

; part 1
(define has-3-vowels?
  (build-matcher #px"([aeiou].*){2}[aeiou]"))

(define has-double-letter?
  (build-matcher #px"(.)\\1"))

(define has-naughty-part?
  (build-matcher #rx"ab|cd|pq|xy"))

(solve (list has-3-vowels?
             has-double-letter?
             (compose not has-naughty-part?)))

; part 2
(define has-pair?
  (build-matcher #px"(..).*\\1"))

(define has-one-between?
  (build-matcher #px"(.).\\1"))

(solve (list has-pair?
             has-one-between?))
