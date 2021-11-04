#lang scribble/manual

@;; to remove the red links, try
@;; $ scribble +m --htmls --dest htmls --redirect-main http://docs.racket-lang.org main.scrbl && xdg-open htmls/main/index.html


@(require (for-label text-block racket/base racket/list racket/math)
          "example.rkt")

@(define the-eval (make-eval 'text-block 'racket/list 'racket/math))

@title{Text block combiners and basic operations}

@defproc[(make-tblock [nrow exact-nonnegative-integer?]
                      [ncol exact-nonnegative-integer?]
                      [char char? #\space])
         tblock]{
Returns a new tblock with @racketid[nrow] rows and @racketid[ncol] columns
 filled with the character @racketid[char].

 @display-example[the-eval (displayln (make-tblock 5 10 #\*))]
}

@defproc[(build-tblock [nrow exact-nonnegative-integer?]
                       [ncol exact-nonnegative-integer?]
                       [get-char (-> exact-nonnegative-integer?
                                     exact-nonnegative-integer?
                                     char?)])
         tblock?]{
Returns a new tblock with @racketid[nrow] rows and @racketid[ncol] columns
 and calls @racket[get-char] for each (row, column) to obtain the corresponding character.

 @display-example[the-eval
                  (displayln
                   (build-tblock 2 26 (λ (row col) (integer->char
                                                    (+ 65 col (* row 32))))))]
}

@defproc[(happend [#:align align (or/c 'top 'center 'bottom 'baseline) 'baseline]
                  [#:pad-char pad-char char? #\space]
                  [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] horizontally.}

@display-example[the-eval (displayln (happend "A\nA"
                                              " "
                                              "B\nB\nB\nB"
                                              ":\n:"
                                              "C\nC"
                                              #:align 'center))]


@defproc[(vappend [#:align align (one-of/c 'left 'center 'right) 'left]
                  [#:pad-char char? pad-char #\space]
                  [#:baseline-of t-bl
                   (or/c exact-nonnegative-integer?
                         'first 'second 'last
                         (list exact-nonnegative-integer?)
                         tblock?)
                   (if (empty? ts) 0 'first)]
                  [t tblock/any] ...)
         tblock?]{
Appends the tblocks @racketid[t] vertically.

If @racketid[t-bl] is a number, it is used as the corresponding row of the resulting tblock.
If @racketid[t-bl] is one of the symbols, or @racket[tblock?] (member of @racketid[ts]),
or a number in parenthesis (considered as an index in @racketid[ts]),
 then the baseline of the corresponding element in @racketid[ts] is used as the new baseline.

 @display-example[the-eval (displayln (vappend "Twinkle, twinkle,"
                                               "Little star,"
                                               "How I wonder what you are!"
                                               #:align 'center))]
}

@defproc[(superimpose [t1 tblock/any]
                      [t2 block/any]
                      [rpos (or/c exact-integer?
                                  (-> exact-nonnegative-integer?
                                      exact-nonnegative-integer?
                                      exact-integer?)
                                  'top
                                  'center
                                  'bottom)]
                      [cpos (or/c exact-integer?
                                  (-> exact-nonnegative-integer?
                                      exact-nonnegative-integer?
                                      exact-integer?)
                                  'left
                                  'center
                                  'right)])
         tblock?]{
 Returns a new tblock where @racketid[t2] is superimposed over @racketid[t1].
 The position @racketid[rpos] can either be
 a number relative to the top left of @racketid[t1],
 a procedure that takes the widths of both @racket[t1] and @racket[t2]
 and returns a number relative to the top left of @racketid[t1],
 or a symbolic value---and similarly for @racketid[cpos].

 @display-example[the-eval
                  (displayln (superimpose (make-tblock 8 4 #\.)
                                          "AB\nCD"
                                          'bottom 'right))
                  (displayln (superimpose (make-tblock 8 4 #\.)
                                          "AB\nCD"
                                          1 'left))
                  (displayln (superimpose (make-tblock 10 20 #\.)
                                          "AB\nCD"
                                          'center
                                          (λ (w1 w2) (exact-truncate (* 3/4 (- w1 w2))))))]
}

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
 @display-example[the-eval
                  (displayln (frame (lines->tblock "Someone framed me!\nI swear!"
                                                 #:pad-char #\.)
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


@defproc*[([(hflip [t tblock/any]) tblock?]
           [(vflip [t tblock/any]) tblock?])]{
 Returns a new tblock like @racketid[t], flipped either horizontally or vertically.

 @display-example[the-eval
                  (displayln (vflip "ab\nAB"))
                  (displayln (hflip "ab\nAB"))]
}

