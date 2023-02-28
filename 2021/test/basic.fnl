(import-macros {: test} :tester)
(local lu (require :luaunit))

(local basic (require :basic))

(test
  basic
  (lu.assertTrue basic))