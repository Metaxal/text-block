#lang scribble/manual

@(require (for-label text-block))

@title{Text block combiners}


@defproc[(happend
          [#:align align (or/c 'top 'center 'bottom 'baseline) 'baseline]
          [#:pad-char pad-char char? #\space]
          [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] horizontally.}


@defproc[(vappend [#:align align (one-of/c 'left 'center 'right) 'left]
                         [#:pad-char char? pad-char #\space]
                         [#:baseline-of t-bl (or/c #f tblock?) #f]
                         [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] vertically.

If @racketid[t-bl] is not @racket[#f] and @racket[t-bl] is a member of @racket[t ...]
(according to @racket[eq?]), then the baseline of the returned tblock is on the same line
as the baseline of @racketid[t-bl].}

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

TODO: example of custom style
}

