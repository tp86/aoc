(import (chicken io))

(print
  (with-input-from-file
    "input.txt"
    (lambda ()
      (let loop ((c (read-char))
                 (floor 0))
        (cond
          ((eof-object? c) floor)
          (else
            (loop
              (read-char)
              ((case c
                 ((#\() (lambda (f) (+ f 1)))
                 ((#\)) (lambda (f) (- f 1)))
                 (else identity))
               floor))))))))
