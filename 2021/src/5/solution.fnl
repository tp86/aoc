(local {: view} (require :fennel))

(fn make-point [x y]
  (setmetatable {: x : y}
                {:__eq (fn [{:x x1 :y y1} {:x x2 :y y2}]
                          (and (= x1 x2) (= y1 y2)))}))

(fn parse-input [input]
  (icollect [x1 y1 x2 y2 (input:gmatch "(%d+),(%d+) %-%> (%d+),(%d+)")]
    {:start {:x (tonumber x1) :y (tonumber y1)}
     :end {:x (tonumber x2) :y (tonumber y2)}}))

(fn hor-or-vert? [line]
  (let [{:start {:x x1 :y y1} :end {:x x2 :y y2}} line]
    (if (or (= x1 x2) (= y1 y2))
      line)))

(fn make-grid []
  (let [hash-fn (fn [{: x : y}] (string.pack "nn" x y))]
    (setmetatable {} {:__index (fn [t k] (rawget t (hash-fn k)))
                      :__newindex (fn [t k v] (rawset t (hash-fn k) v))})))

(fn line-points [line]
  (let [{:start {:x x1 :y y1} :end {:x x2 :y y2}} line]
    (if
      (= x1 x2)
      (fcollect [y (math.min y1 y2) (math.max y1 y2)]
        (make-point x1 y))

      (= y1 y2)
      (fcollect [x (math.min x1 x2) (math.max x1 x2)]
        (make-point x y1)))))

(fn add-to-grid [grid line]
  (each [_ point (ipairs (line-points line))]
    (let [count (or (. grid point) 0)]
      (tset grid point (+ count 1)))))

(fn solve-1 [input]
  (let [lines (icollect [_ line (ipairs input)]
                (hor-or-vert? line))
        grid (make-grid)]
    (each [_ line (ipairs lines)]
      (add-to-grid grid line))
    (accumulate [sum 0
                 _ count (pairs grid)]
      (if (< 1 count)
        (+ sum 1)
        sum))))

(fn solve-2 [input])

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}
