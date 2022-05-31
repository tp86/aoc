(import (chicken port))
(import (chicken io))
(import srfi-13)

(define (helper-has-pair?)
  (let loop ((c1 (read-char))
             (c2 (read-char)))
    (cond
      ((eof-object? c2) #f)
      ((string-contains (list->string (list c11 c12)) (list->string (list c21 c22))) #t)
      (else
        (loop c12
              c21
              c22
              (read-char))))))
(define (has-pair? str)
  (with-input-from-string str helper-has-pair?))

(string-contains "defabc" "ab")
(has-pair? "xyxy")

(define (helper-has-separated-letter?)
  (let loop ((c1 (read-char))
             (c2 (read-char))
             (c3 (read-char)))
    (cond
      ((eof-object? c3) #f)
      ((eq? c1 c3) #t)
      (else
        (loop c2
              c3
              (read-char))))))
(define (has-separated-letter? str)
  (with-input-from-string str helper-has-separated-letter?))

(has-separated-letter? "abc")

(define (is-nice? str)
  (and (has-pair? str)
       (has-separated-letter? str)))

(is-nice? "qjhvhtzxzqqjkmpb")

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
