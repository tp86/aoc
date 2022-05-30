(define input "yzbqklnj")

(import simple-md5 srfi-13)

(let loop ((num 0))
  (let* ((nstr (number->string num))
         (h (string->md5sum (string-append input nstr))))
    (cond
      ((string-prefix? "00000" h) num)
      (else (loop (+ num 1))))))
