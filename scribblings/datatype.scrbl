#lang scribble/manual
@require[@for-label[text-block
                    racket/contract
                    racket/base
                    racket/format]]

@title{Text block datatype}

TODO: tblock struct

@defproc[(tblock? [x any/c]) boolean?]{
Returns whether @racketid[x] is a @racket[tblock].}

@defproc[(tblock/any [x any/c]) boolean?]{
A fake contract equivalent to @racket[any/c].
Used as a placeholder to indicate that the corresponding
argument is turned into a @racket[tblock] using @racket[->tblock].}

@defproc[(->tblock [x tblock/any]) tblock?]{
Returns @racket[x] if it is already a @racket[tblock?], otherwise
returns a new @racket[tblock] by turning @racketid[x] into a string first
using @racket[~a].}

@defproc[(make-tblock (lines (or/c string? (listof string?)))
                     [#:align align (one-of/c 'left 'center 'right) 'left]
                     [#:pad-char pad-char char? #\space]
                     [#:baseline baseline exact-nonnegative-integer? 0])
         tblock?]{
Returns a new @racket[tblock].}

