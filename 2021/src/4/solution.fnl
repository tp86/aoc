(fn parse-draws [line]
  (icollect [num (line:gmatch "%d+")]
    (tonumber num)))
(fn make-board []
  (local board [])
  (for [row 1 5]
    (tset board row [])
    (for [col 1 5]
      (tset (. board row) col {:value nil
                               :marked false})))
  board)
(fn insert-numbers [row line]
  (var pos 1)
  (each [num (line:gmatch "%d+")]
    (tset (. row pos) :value (tonumber num))
    (set pos (+ pos 1))))
(fn parse-input [input]
  (local game {:draws []
               :boards []})
  (let [lines (icollect [line (input:gmatch "[^\n]*")]
                line)]
    (var row 1)
    (for [line-number 1 (length lines)]
      (local line (. lines line-number))
      (if
        (= line-number 1)
        (set game.draws (parse-draws line))

        (and (= line "") (not= line-number (length lines)))
        (do
          (table.insert game.boards (make-board))
          (set row 1))

        (let [board (. game.boards (length game.boards))]
          (insert-numbers (. board row) line)
          (set row (+ row 1))))))
  game)

(fn mark-board [board number]
  (each [row-idx col (ipairs board)]
    (each [col-idx {: value &as entry} (ipairs col)]
      (when (= value number)
        (set entry.marked true)))))

(fn mark [boards number]
  (each [_ board (ipairs boards)]
    (mark-board board number)))

(fn check-board [board]
  (var wins? false)
  (for [row-idx 1 5 &until wins?]
    (set wins? true)
    (for [col-idx 1 5]
      (let [{: marked} (. (. board row-idx) col-idx)]
        (set wins? (and wins? marked)))))
  (when (not wins?)
    (for [col-idx 1 5 &until wins?]
      (set wins? true)
      (for [row-idx 1 5]
        (let [{: marked} (. (. board row-idx) col-idx)]
          (set wins? (and wins? marked))))))
  wins?)

(fn check [boards]
  (var winning-board nil)
  (each [_ board (ipairs boards) &until winning-board]
    (when (check-board board)
      (set winning-board board)))
  winning-board)

(fn sum-unmarked [board]
  (var sum 0)
  (each [_ row (ipairs board)]
    (each [_ {: value : marked} (ipairs row)]
      (when (not marked)
        (set sum (+ sum value)))))
  sum)

(fn solve-1 [input]
  (let [{: draws : boards} input]
    (var winning-board nil)
    (var number-drawn nil)
    (each [i number (ipairs draws) &until winning-board]
      (set number-drawn number)
      (mark boards number)
      (let [board (check boards)]
        (when board
          (set winning-board board))))
    (* number-drawn (sum-unmarked winning-board))))

(fn check-left [boards]
  (icollect [_ board (ipairs boards)]
    (if (not (check-board board)) board)))

(fn solve-2 [input]
  (let [{: draws : boards} input]
    (var all-winning false)
    (var last-board nil)
    (var number-drawn nil)
    (each [i number (ipairs draws) &until all-winning]
      (set number-drawn number)
      (mark boards number)
      (let [boards-left (check-left boards)]
        (when (= 1 (length boards-left))
          (set last-board (. boards-left 1)))
        (when (= 0 (length boards-left))
          (set all-winning true))))
    (* number-drawn (sum-unmarked last-board))))

(fn solve [input solver]
  (solver (parse-input input)))

{:solve-1 (fn [input] (solve input solve-1))
 :solve-2 (fn [input] (solve input solve-2))}
