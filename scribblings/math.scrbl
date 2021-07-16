#lang scribble/manual
@require[@for-label[text-block
                    text-block/math
                    text-block/symbols
                    racket/contract
                    racket/base
                    racket/format
                    racket/string
                    racket/require]
         racket/port
         scribble/example
         text-block
         text-block/math
         "example.rkt"]

@(define the-eval (make-eval 'text-block))

@title{Text block: maths and formulas}

@defmodule[text-block/math]

The functions exported by @racketmodname[text-block/math] are prefixed with @racketid[$]
to avoid name collisions with Racket's arithmetic functions.
The default prefix can be changed on @racket[require] with @racket[filtered-in], for example:
@examples[#:eval (make-base-eval #:lang 'racket/base)
 (require racket/require
          (for-syntax racket/base racket/string)
          (filtered-in (lambda (name)
                         (and (char=? #\$ (string-ref name 0))
                              (string-replace name "$" "¶")))
                       text-block/math))
 (¶+ 'a 'b)]


@defproc*[([($+ [t tblock/any] ...) tblock?]
           [($- [t tblock/any] ...) tblock?]
           [($/ [t tblock/any] ...) tblock?]
           [($* [t tblock/any] ...) tblock?]
           [($sqr   [t tblock/any]) tblock?]
           [($cube  [t tblock/any]) tblock?]
           [($sqrt  [t tblock/any]) tblock?]
           [($expt  [t1 tblock/any] [t2 tblock/any]) tblock?]
           [($integral [below tblock/any] [above tblock/any]) tblock?]
           [($sum      [below tblock/any] [above tblock/any]) tblock?]
           [($product  [below tblock/any] [above tblock/any]) tblock?]
           )]{
Compose tblocks horizontally for arithmetic operations.

The functions @racket[$sqr], @racket[$cube] and @racket[$expt] may add parenthesis
around their first argument to avoid ambiguity.
}

@defproc*[([($_ [t tblock/any] [t_ tblock/any]) tblock?]
           [($^ [t tblock/any] [t^ tblock/any]) tblock?]
           [($^_ [t tblock/any] [t^ tblock/any] [t_ tblock/any]) tblock?]
           [($_^ [t tblock/any] [t^ tblock/any] [t_ tblock/any]) tblock?]
           )]{
Places a tblock as a subscript, as superscript, or as both, relative to @racketid[t].

@display-example[the-eval
                 (displayln (happend ($_ "log" 'n) "(x)"))
                 (displayln ($_^ ($square-bracket (happend "3" ($sqrt 'x)))
                                 "x=1"
                                 ($sqr "n")))]
}

@defproc*[([($left-brace  [t tblock/any] ...) tblock?]
           [($right-brace [t tblock/any] ...) tblock?]
           [($brace       [t tblock/any] ...) tblock?]
           [($left-paren  [t tblock/any] ...) tblock?]
           [($right-paren [t tblock/any] ...) tblock?]
           [($paren       [t tblock/any] ...) tblock?]
           [($left-square-bracket  [t tblock/any] ...) tblock?]
           [($right-square-bracket [t tblock/any] ...) tblock?]
           [($square-bracket       [t tblock/any] ...) tblock?]
           [($left-ceiling  [t tblock/any] ...) tblock?]
           [($right-ceiling [t tblock/any] ...) tblock?]
           [($ceiling       [t tblock/any] ...) tblock?]
           [($left-floor  [t tblock/any] ...) tblock?]
           [($right-floor [t tblock/any] ...) tblock?]
           [($floor       [t tblock/any] ...) tblock?]
           )]{
Each function places a bracket of some shape to the left or right of the @racketid[t]s,
or encloses them with both brackets.

 @display-example[
 the-eval
 (displayln
  ($ceiling
   (happend "3x + "
            ($left-brace (lines->tblock
                          '("a if x > 0"
                            "b if x < 0"
                            "c if x = 0")
                          #:baseline 1)))))]
}

@defproc*[([($overbrace  [t tblock/any] [t^ tblock/any]) tblock?]
           [($underbrace [t tblock/any] [t_ tblock/any]) tblock?])]{
 Places a brace and @racket[t^] or @racket[t_] above or below the tblock @racketid[t].
 The baseline of the returned tblock is the same as that of @racket[t].

 @display-example[
 the-eval
 (displayln
  (happend ($overbrace " Mon verre est vide. " "optimiste…")
           ($underbrace " C'est un message. " "…ayant soif")))]
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


