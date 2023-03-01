(fn parse-input [input]
  (icollect [direction value (input:gmatch "(%w+) (%d+)")]
    [direction (tonumber value)]))

(fn solve [input move-fns pos]
  (local moves
    (icollect [_ [direction value] (ipairs input)]
      (partial (. move-fns direction) value)))
  (each [_ f (ipairs moves)]
    (f pos))
  (* pos.x pos.y))

(fn solve-1 [input]
  (local move-fns
    {:forward (fn [i {: x &as pos}] (set pos.x (+ x i)) pos)
     :down (fn [i {: y &as pos}] (set pos.y (+ y i)) pos)
     :up (fn [i {: y &as pos}] (set pos.y (- y i)) pos)})
  (local pos {:x 0 :y 0})
  (solve input move-fns pos))

(fn solve-2 [input]
  (local move-fns
    {:forward (fn [i {: x : y : aim &as pos}]
                (set pos.x (+ x i))
                (set pos.y (+ y (* aim i)))
                pos)
     :down (fn [i {: aim &as pos}] (set pos.aim (+ aim i)) pos)
     :up (fn [i {: aim &as pos}] (set pos.aim (- aim i)) pos)})
  (local pos {:x 0 :y 0 :aim 0})
  (solve input move-fns pos))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}
