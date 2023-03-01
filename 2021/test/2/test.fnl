(import-macros {: test} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "forward 5
down 5
forward 8
up 3
down 8
forward 2")
(local answer-1 150)
(local answer-2 900)

(test
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))
