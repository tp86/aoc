(fn parse-input [input]
  (icollect [entry (input:gmatch "%d+")]
    (tonumber entry)))

(fn solve-1 [input]
  (fn solve [input sum]
    (case input
      [m1 m2 & rest] (solve [m2 (table.unpack rest)]
                            (if (< m1 m2) (+ sum 1) sum))
      _ sum))
  (solve input 0))

(fn solve-2 [input]
  (fn solve [input sum]
    (case input
      [m1 m2 m3 m4 & rest] (solve [m2 m3 m4 (table.unpack rest)]
                                  (if (< (+ m1 m2 m3) (+ m2 m3 m4)) (+ sum 1) sum))
      _ sum))
  (solve input 0))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}
