(import (chicken port))
(import (chicken io))

(define input "input.txt")

(define lines
  (with-input-from-file
    input
    (lambda ()
      (let loop ((line (read-line)) (lines '()))
        (if (eof-object? line)
          (reverse lines)
          (loop (read-line) (cons line lines)))))))

(define (parse line)
  (with-input-from-string line
    (lambda ()
      (let loop ((c (read-char))
                 (floor 0))
        (cond
          ((eof-object? c) floor)
          (else
            (case c
              ((#\() (loop (read-char) (+ floor 1)))
              ((#\)) (loop (read-char) (- floor 1))))))))))

(parse (car lines))
