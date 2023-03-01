(import-macros {: test} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "")
(local answer-1 nil)
(local answer-2 nil)

(test
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))
