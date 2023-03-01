(import-macros {: test} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "199
200
208
210
200
207
240
269
260
263")
(local answer-1 7)
(local answer-2 5)

(test
  part-1
  (lu.assertEquals (solve-1 sample) answer-1))

(test
  part-2
  (lu.assertEquals (solve-2 sample) answer-2))
