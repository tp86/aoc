(import-macros {: test} :tester)
(local lu (require :luaunit))

(local {: solve-1 : solve-2} (require :solution))

(local sample "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010")
(local answer-1 198)
(local answer-2 230)

(test
  "part-1"
  (lu.assertEquals (solve-1 sample) answer-1))

(test
  "part-2"
  (lu.assertEquals (solve-2 sample) answer-2))
