#lang scribble/manual
@require[@for-label[racket/base
                    racket/contract
                    racket/format
                    text-block]
         text-block
         racket/base]

@title{Text block datatype}

@defmodule[text-block/tblock]

@defstruct[tblock ([width    exact-nonnegative-integer?]
                   [height   exact-nonnegative-integer?]
                   [baseline exact-nonnegative-integer?]
                   [lines    (listof string?)])
           ;#:extra-constructor-name #f
           #:omit-constructor]{
The @racket[tblock] structure.
Do not use @racket[tblock] for construction, use @racket[make-tblock] instead.

Only the @racketid[baseline] field is mutable.}


@defproc[(make-tblock (lines (or/c string? (listof string?)))
                     [#:align align (one-of/c 'left 'center 'right) 'left]
                     [#:pad-char pad-char char? #\space]
                     [#:baseline baseline exact-nonnegative-integer? 0])
         tblock?]{
Returns a new @racket[tblock].}

@defproc[(tblock/any [x any/c]) boolean?]{
A fake contract equivalent to @racket[any/c].
Used as a placeholder to indicate that the corresponding
argument is turned into a @racket[tblock] using @racket[->tblock].}

@defproc[(->tblock [x tblock/any]) tblock?]{
Returns @racket[x] if it is already a @racket[tblock?], otherwise
returns a new @racket[tblock] by turning @racketid[x] into a string first
using @racket[~a].}

