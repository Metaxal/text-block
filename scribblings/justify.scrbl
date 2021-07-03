#lang scribble/manual

@(require (for-label text-block/justify)
          scribble/example)

@title{Text block: Justify text}
@defmodule[text-block/justify]

@(define the-eval (make-base-eval))

@defproc[(text->lines [text string?]
                      [ncol exact-integer?]
                      [#:align align (one-of 'none 'left 'center 'right 'justified) 'none])
         (listof string?)]{
Splits the given string and justifies it to the specified number of columns.
}

@examples[#:eval the-eval #:hidden
          (require racket/string
                   text-block/justify)]

@(examples
  #:eval the-eval
  (define lorem-ipsum
    (string-append
     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
     "sed do eiusmod tempor incididunt ut labore et dolore magna "
     "aliqua. Ut enim ad minim veniam, quis nostrud exercitation"))
  (text->lines lorem-ipsum 43 #:align 'none)
  (text->lines lorem-ipsum 43 #:align 'justified)
  (text->lines lorem-ipsum 70 #:align 'justified)
  (text->lines lorem-ipsum 43 #:align 'center)
  (text->lines lorem-ipsum 43 #:align 'right))