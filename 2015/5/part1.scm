(import (chicken port))
(import (chicken io))

(define (helper-has-3-vowels?)
  (let loop ((c (read-char))
             (vowels 0))
    (cond
      ((= vowels 3) #t)
      ((eof-object? c) #f)
      (else
        (loop (read-char)
              (case c
                ((#\a #\e #\i #\o #\u) (+ vowels 1))
                (else vowels)))))))
(define (has-3-vowels? str)
  (with-input-from-string str helper-has-3-vowels?))

(has-3-vowels? "aaa")

(define (has-double-letter?)
  (let loop ((c1 (read-char))
             (c2 (read-char)))
    (cond
      ((eq? c1 c2) #t)
      ((eof-object? c2) #f)
      (else
        (loop c2
              (read-char))))))
(define (has-letter-twice? str)
  (with-input-from-string str has-double-letter?))

(has-letter-twice? "aaa")

(define (helper-has-naughty-part?)
  (let loop ((c1 (read-char))
             (c2 (read-char)))
    (cond
      ((eof-object? c2) #f)
      (else
        (if (member (list->string (list c1 c2)) (list "ab" "cd" "pq" "xy"))
          #t
          (loop c2
                (read-char)))))))
(define (has-naughty-part? str)
  (with-input-from-string str helper-has-naughty-part?))

(has-naughty-part? "haexiyu")

(define (is-nice? str)
  (and (has-3-vowels? str)
       (has-letter-twice? str)
       (not (has-naughty-part? str))))

(with-input-from-file "input.txt"
                      (lambda ()
                        (let loop ((l (read-line))
                                   (count 0))
                          (cond
                            ((eof-object? l) count)
                            (else
                              (loop (read-line)
                                    (if (is-nice? l)
                                      (+ count 1)
                                      count)))))))
