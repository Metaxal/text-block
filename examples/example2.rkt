#lang racket/base
(require text-block)

;; A show-off meaningless formula
(displayln
 (happend
  #:align 'baseline
  ($product "x = 1" ($floor ($+ ($/ ($sqr "X") "2") "3")))
  "exp"
  ($brace ($/ ($sqrt
               ($+ (happend
                    "log"
                    ($paren ($/ (happend ($/ 2 3) " x + " @2/3 "y")
                                (happend "bx" @^- @^1 "-3"))))
                   (happend
                    ($integral "3y" @infty)
                    (happend
                     ($/ (happend "a" ($sqr "x") "+2")
                         (happend "bx" @^3 "-3"))
                     " dx"))
                   "2x+3"))
              ($+ ($/ (happend "ax" @^- @^2 "+2")
                      (happend "bx" @^4 "-3"))
                  ($/ ($ceiling
                       ($/ "ax²+2"
                           "bx³-3"))
                      ($paren (happend ($sum "n=1" "N") "log" @_2 " n"))))))))
