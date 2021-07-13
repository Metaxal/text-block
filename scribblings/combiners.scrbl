#lang scribble/manual

@(require (for-label text-block)
          "example.rkt")

@(define the-eval (make-eval 'text-block))

@title{Text block combiners and basic operations}

@;defmodule[text-block]

@defproc[(happend
          [#:align align (or/c 'top 'center 'bottom 'baseline) 'baseline]
          [#:pad-char pad-char char? #\space]
          [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] horizontally.}

@display-example[the-eval (displayln (happend "A\nA" " " "B\nB\nB\nB" ":\n:" "C\nC" #:align 'center))]


@defproc[(vappend [#:align align (one-of/c 'left 'center 'right) 'left]
                         [#:pad-char char? pad-char #\space]
                         [#:baseline-of t-bl (or/c #f tblock?) #f]
                         [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] vertically.

If @racketid[t-bl] is not @racket[#f] and @racket[t-bl] is a member of @racket[t ...]
(according to @racket[eq?]), then the baseline of the returned tblock is on the same line
as the baseline of @racketid[t-bl].}

@display-example[the-eval (displayln (vappend "Twinkle, twinkle,"
                                         "Little star,"
                                         "How I wonder what you are!"
                                         #:align 'center))]

@defthing[frame-style/c contract?]{
 A contract for @racket[frame] styles.
 Matches @racket[(or/c (one-of/c 'single 'round 'double)
                       (list/c string? string? string?))]
 where the list of strings is for defining custom styles.
}

@defproc[(frame
          [t tblock/any]
          [#:style style frame-style/c 'single]
          [#:inset inset exact-nonnegative-integer? 0])
         tblock?]{
 Adds a frame aronud the tblock @racketid[t].

 @display-example[the-eval (displayln (frame "Someone framed me!\nI swear!"))]

 A custom style defines all characters of the frame as well as the padding character:
 @display-example[the-eval (displayln (frame "Someone framed me!\nI swear!"
                                        #:inset 2
                                        #:style '("(+)"
                                                  "[.]"
                                                  "{~}")))]
}

@defproc*[([(overline [t tblock/any]) tblock?]
           [(underline [t tblock/any]) tblock?])]{
Draws a line above or below the text.

@display-example[the-eval (displayln (happend (overline "hello") " " (underline 'there) "!"))]
}

