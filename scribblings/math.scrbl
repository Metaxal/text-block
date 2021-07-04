#lang scribble/manual
@require[@for-label[text-block
                    text-block/math
                    racket/contract
                    racket/base
                    racket/format]
         racket/port
         scribble/example
         text-block
         text-block/math]

@(require scribble/core
          scribble/html-properties)

@(define example-style
   (make-style "example"
               (list (make-css-addition "../example.css"))))

@(define the-eval (make-base-eval))

@examples[#:eval the-eval #:hidden
          (require racket/string
                   racket/port
                   text-block)]

@; Better formatting for unicode 2d text
@(define-syntax-rule (my-example eval expr)
   (let ()
     (define out (eval '(with-output-to-string (λ () expr))))
     (list (para "Example:")
           (racketblock expr)
           (elem
            #:style example-style
            (list '() out)))))


@title{Text block: maths and formulas}

@defmodule[text-block/math]

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

@(my-example
  the-eval
  (displayln ($formula '(+ (sqrt
                            (/ (log (/ (+ x 3)
                                       (- x 2)))
                               (- (expt x y) z)))
                           (f a b (/ c (+ a b)))))))
