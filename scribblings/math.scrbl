#lang scribble/manual
@require[@for-label[text-block
                    text-block/math
                    racket/contract
                    racket/base
                    racket/format]
         racket/port
         text-block
         text-block/math
         "example.rkt"]

@(define the-eval (make-eval 'text-block))
@(require scribble/example)
@examples[#:eval the-eval #:hidden (require text-block)]

@title{Text block: maths and formulas}

@defmodule[text-block/math]

@defproc*[([($+ [t tblock/any] ...) tblock?]
           [($- [t tblock/any] ...) tblock?]
           [($/ [t tblock/any] ...) tblock?]
           [($* [t tblock/any] ...) tblock?]
           [($sqr  [t tblock/any]) tblock?]
           [($sqrt [t tblock/any]) tblock?]
           [($integral [below tblock/any] [above tblock/any]) tblock?]
           [($sum      [below tblock/any] [above tblock/any]) tblock?]
           [($product  [below tblock/any] [above tblock/any]) tblock?]
           )]{
Compose tblocks horizontally for arithmetic operations.}

@defproc*[([($left-brace  [t tblock/any]) tblock?]
           [($right-brace [t tblock/any]) tblock?]
           [($brace       [t tblock/any]) tblock?]
           [($left-paren  [t tblock/any]) tblock?]
           [($right-paren [t tblock/any]) tblock?]
           [($paren       [t tblock/any]) tblock?]
           [($left-square-bracket  [t tblock/any]) tblock?]
           [($right-square-bracket [t tblock/any]) tblock?]
           [($square-bracket       [t tblock/any]) tblock?]
           [($left-ceiling  [t tblock/any]) tblock?]
           [($right-ceiling [t tblock/any]) tblock?]
           [($ceiling       [t tblock/any]) tblock?]
           [($left-floor  [t tblock/any]) tblock?]
           [($right-floor [t tblock/any]) tblock?]
           [($floor       [t tblock/any]) tblock?]
           )]{
Each function places a bracket of some shape to the left or right of @racketid[t], or encloses it with both brackets.
}

@defproc[($formula [tree any/c]) tblock?]{
Formats the given racket quoted math expression @racketid[tree] as a @racket[tblock].
}

Examples:
@(display-example
  the-eval
  (displayln
   ($formula '(+ (sqrt
                  (/ (log (/ (+ x 3)
                             (- x 2)))
                     (- (expt x y) z)))
                 (f a b (/ c (+ a b)))))))

@(display-example
  the-eval
  (displayln
   ($/ (happend "-b ± " ($sqrt "b² - 4ac"))
       ($* 2 'a))))

@(display-example
  the-eval
  (displayln
   (happend |@sigma|
            " = "
            ($sqrt (happend
                    ($/ 1 'N)
                    " "
                    ($sum "i=1" 'N)
                    ($sqr ($- ($_ 'x 'i)
                              |@mu|)))))))


