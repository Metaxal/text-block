#lang scribble/manual
@require[@for-label[text-block
                    racket/contract
                    racket/base
                    racket/format]]

@title{text-block}
@author{Laurent Orseau}

@defmodule[text-block]

@racketmodname[text-block] is a library to manipulate rectangular blocks
of unicode text.

@verbatim{
 XXX
}


@defproc[(tblock? [x any/c]) boolean?]{
Returns whether @racketid[x] is a @racket[tblock].}

@(define tblock/x void)

@defproc[(tblock/x [x any/c]) boolean?]{
A fake contract that always returns true.
Used as a placeholder to indicate that the corresponding
argument is turned into a @racket[tblock?] using @racket[->tblock].}

@defproc[(->tblock [x any/c]) tblock?]{
Returns @racket[x] if it is already a @racket[tblock?], otherwise
returns a new @racket[tblock] by turning @racketid[x] into a string first
using @racket[~a].}

@defproc[(make-tblock (lines (or/c string? (listof string?)))
                     [#:align align (one-of/c 'left 'center 'right) 'left]
                     [#:pad-char pad-char char? #\space]
                     [#:baseline baseline exact-nonnegative-integer? 0])
         tblock?]{
Returns a new @racket[tblock].}

@defproc[(tblock-happend
          [#:align align (or/c 'top 'center 'bottom 'baseline) 'baseline]
          [#:pad-char pad-char char? #\space]
          [t tblock/x] ...)
         tblock?]{
Appends the tblocks @racketid[t] horizontally.}


@defproc[(tblock-vappend [#:align align (one-of/c 'left 'center 'right) 'left]
                         [#:pad-char char? pad-char #\space]
                         [#:baseline-of t-bl (or/c #f tblock?) #f]
                         [t tblock/x] ...)
         tblock?]{
Appends the tblocks @racketid[t] vertically.

If @racketid[t-bl] is not @racket[#f] and @racket[t-bl] is a member of @racket[t ...]
(according to @racket[eq?]), then the baseline of the returned tblock is on the same line
as the baseline of @racketid[t-bl].}


