(import (chicken io))
(import (chicken string))

(print
  (with-input-from-file
    "input.txt"
    (lambda ()
      (let loop ((line (read-line))
                 (sum 0))
        (cond
          ((eof-object? line) sum)
          (else
            (let* ((splitted (string-split line "x"))
                   (l (string->number (car splitted)))
                   (w (string->number (cadr splitted)))
                   (h (string->number (caddr splitted)))
                   (lw (+ l w))
                   (lh (+ l h))
                   (hw (+ h w))
                   (m (min lw hw lh))
                   (ribbon (* l w h)))
              (loop
                (read-line)
                (+ sum
                   (* 2 m)
                   ribbon)))))))))
