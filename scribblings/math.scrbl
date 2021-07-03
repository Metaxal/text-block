#lang scribble/manual
@require[@for-label[text-block
                    text-block/math
                    racket/contract
                    racket/base
                    racket/format]
         scribble/example
         text-block
         text-block/math]

@title{Text block: maths and formulas}

@defmodule[text-block/math]

@(define the-eval (make-base-eval))

@examples[#:eval the-eval #:hidden
          (require racket/string
                   text-block/math)]

@defproc*[([($+ [t tblock/any] ...) tblock?]
           [($/ [t tblock/any] ...) tblock?]
           [($* [t tblock/any] ...) tblock?]
           [($sqrt [t tblock/any]) tblock?]
           [($integral [below tblock/any] [above tblock/any]) tblock?]
           [($sum [below tblock/any] [above tblock/any]) tblock?]
           [($product [below tblock/any] [above tblock/any]) tblock?]
           )]{
Compose tblocks horizontally for arithmetic operations.}

@defproc*[([($left-brace [t tblock/any]) tblock?]
           [($right-brace [t tblock/any]) tblock?]
           [($brace [t tblock/any]) tblock?]
           [($left-paren [t tblock/any]) tblock?]
           [($right-paren [t tblock/any]) tblock?]
           [($paren [t tblock/any]) tblock?]
           [($left-square-bracket [t tblock/any]) tblock?]
           [($right-square-bracket [t tblock/any]) tblock?]
           [($square-bracket [t tblock/any]) tblock?]
           [($left-ceiling [t tblock/any]) tblock?]
           [($right-ceiling [t tblock/any]) tblock?]
           [($ceiling [t tblock/any]) tblock?]
           [($left-floor [t tblock/any]) tblock?]
           [($right-floor [t tblock/any]) tblock?]
           [($floor [t tblock/any]) tblock?]
           )]{
Each function places a bracket of some shape to the left or right of @racketid[t], or encloses it with both brackets.
}

@defproc[($formula [tree any/c]) tblock?]{
Formats the given racket quoted math expression @racketid[tree] as a @racket[tblock].
}

@examples[
 #:eval the-eval
 (displayln ($formula '(+ (sqrt
                           (/ (log (/ (+ x 3)
                                      (- x 2)))
                              (- (expt x y) z)))
                          (f a b c))))]

