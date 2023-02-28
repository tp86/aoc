(import-macros {: test : suite : before-each : after-each} :tester)
(local lu (require :luaunit))

(local basic (require :basic))

(suite
  basic
  (var obj nil)
  (before-each
    (set obj true))
  (after-each
    (set obj nil))
  (test
    basic
    (lu.assertTrue basic)
    (lu.assertTrue obj)))