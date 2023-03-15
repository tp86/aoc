(fn parse-input [input]
  (icollect [entry (input:gmatch "[^\n]+")]
    entry))

(fn most-common-bit-by-pos [input]
  (let [most-common []]
    (each [_ entry (ipairs input)]
      (each [pos bit (entry:gmatch "()(%d)")]
        (let [current-value (or (. most-common pos) 0)]
          (tset most-common pos
                (if (= bit "0")
                  (- current-value 1)
                  (+ current-value 1))))))
    (each [pos value (ipairs most-common)]
      (if (< value 0)
        (tset most-common pos "0")
        (tset most-common pos "1")))
    most-common))

(fn flip [bits]
  (icollect [_ bit (ipairs bits)]
    (if
      (= bit "0") "1"
      (= bit "1") "0"
      bit)))

(fn bits->num [bits]
  (tonumber bits 2))

(fn solve-1 [input]
  (let [most-common (most-common-bit-by-pos input)
        least-common (flip most-common)
        gamma-rate (table.concat most-common)
        epsilon-rate (table.concat least-common)]
    (* (bits->num gamma-rate) (bits->num epsilon-rate))))

(fn filter-rating [input bitmask-fn]
  (fn bitmask [input pos]
    (. (bitmask-fn input) pos))
  (fn filter-by [input bit pos]
    (if (= 1 (length input))
      (. input 1)
      (let [new-input (icollect [_ bits (ipairs input)]
                       (if (= bit (bits:sub pos pos))
                         bits))
            new-pos (+ pos 1)
            new-bit (bitmask new-input new-pos)]
        (filter-by new-input new-bit new-pos))))
  (let [pos 1
        bit (bitmask input pos)]
    (filter-by input bit pos)))

(fn solve-2 [input]
  (let [oxygen-rating (filter-rating input most-common-bit-by-pos)
        co2-scrubber-rating (filter-rating input #(flip (most-common-bit-by-pos $)))]
    (* (bits->num oxygen-rating) (bits->num co2-scrubber-rating))))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}
