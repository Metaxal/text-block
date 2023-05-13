#lang racket
(require define2
         racket/contract
         "text.rkt")

;;; Text blocks that can be combined like pictures.
;;; Any append operation creates a new rectangular block.

(provide (struct-out tblock)
         (except-out (all-defined-out)
                     make-line-like))

(define tblock/any any/c)

(define (tblock-print tb port mode)
  #;(displayln (list 'mode mode))
  (case mode
    [(#f) (display (tblock->string tb) port)]
    [else
     (define lines (map ~s (tblock-lines tb)))
     (define str (string-join lines "\n"))
     (fprintf port
              "(tblock #:width ~a #:height ~a #:baseline ~a~a)"
              (tblock-width tb)
              (tblock-height tb)
              (tblock-baseline tb)
              (string-append (case mode [(0) " '("] [else " ("])
                             (if (> (length lines) 1) "\n" "")
                             str
                             ")"))]))

;; baseline: row number
(struct tblock (width height [baseline #:mutable] lines)
  #:transparent
  #:methods gen:custom-write
  [(define write-proc tblock-print)])

(define (tblock->string t)
  (string-join (tblock-lines t) "\n"))

(define (string-pad str width align #:char [char #\space])
  (define n (max 0 (- width (string-length str))))
  (if (= 0 n)
    str
    (case align
      [(left) (string-append str (make-string n char))]
      [(right) (string-append (make-string n char) str)]
      [(center)
       (define n/2 (quotient n 2))
       (string-append (make-string n/2 char)
                      str
                      (make-string (- n n/2) char))])))

(module+ test
  (require rackunit)
  (check-equal? (string-pad "abcde" 10 'left #:char #\space)
                "abcde     ")
  (check-equal? (string-pad "abcde" 10 'right #:char #\_)
                "_____abcde")
  (check-equal? (string-pad "abcde" 10 'center #:char #\space)
                "  abcde   "))

;; align: (or/c 'left 'center 'right)
(define (lines->tblock lines
                     #:? [align 'left]
                     #:pad-char [char #\space]
                     #:? [baseline 0])
  (when (string? lines)
    (set! lines (string-split lines "\n" #:trim? #f)))
  (unless (andmap string? lines)
    (raise-argument-error 'make-tblock "(or/c string? (listof string?))" lines))
  (define w (if (empty? lines) 0 (apply max (map string-length lines))))
  (define h (length lines))
  (define new-lines
    (for/list ([line (in-list lines)] [i (in-naturals)])
      (match line
        [(list 'b (? string? str))
         (set! baseline i)]
        [else (void)])
      (string-pad line w align #:char char)))
  (tblock w h baseline new-lines))

(define (baseline! t b)
  (let ([t (->tblock t)])
    (set-tblock-baseline! t b)
    t))

(define (->tblock t)
  (cond [(tblock? t) t]
        [(string? t) (lines->tblock t)]
        [else (lines->tblock (~a t))]))

(define (make-tblock nrow ncol [char #\space])
  (lines->tblock (build-list nrow (λ _ (make-string ncol char)))))

(define (build-tblock nrow ncol proc)
  (lines->tblock
   (for/list ([r (in-range nrow)])
     (apply string (for/list ([c (in-range ncol)])
                     (proc r c))))))

(module+ test
  (check-equal?
   (tblock-lines (build-tblock 2 26 (λ (row col) (integer->char (+ 65 col (* row 32))))))
   '("ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     "abcdefghijklmnopqrstuvwxyz")))

(define (valign-row t align)
  (let ([t (->tblock t)])
    (case align
      [(top) 0]
      [(bottom) (tblock-height t)]
      [(baseline) (tblock-baseline t)]
      [(center) (quotient (tblock-height t) 2)])))

;; align : (or/c 'top 'baseline 'bottom)
(define (happend #:? [align 'baseline] #:pad-char [char #\space]
                        . ts)
  (let ([ts (map ->tblock ts)])
    (define-values (htop hbottom)
      (case align
        [(top)
         (values 0 (apply max (map tblock-height ts)))]
        [(bottom)
         (values (apply max (map tblock-height ts)) 0)]
        [(center)
         (define m (apply max (map tblock-height ts)))
         (define q (quotient m 2))
          (values q (- m q))]
        [(baseline)
         (values (apply max (map tblock-baseline ts))
                 (apply max (map (λ (t) (- (tblock-height t) (tblock-baseline t))) ts)))]))

    (define new-tlines
      (for/list ([t (in-list ts)])
        (define r (valign-row t align))
        (append (make-list (max 0 (- htop r))
                           (make-string (tblock-width t) char))
                (tblock-lines t)
                (make-list (max 0 (- hbottom (- (tblock-height t) r)))
                           (make-string (tblock-width t) char)))))
    (define lines (apply map string-append new-tlines))
    (lines->tblock lines #:baseline htop)))

(define (vappend #:? [align 'left]
                 #:pad-char [char #\space]
                 #:baseline-of [t-bl (if (empty? ts) 0 'first)]
                 . ts)
  (let ([ts (map ->tblock ts)])
    (set! t-bl
          (match t-bl
            [(? tblock?) t-bl]
            ['first (first ts)]
            ['second (second ts)]
            ['last (last ts)]
            [(? exact-nonnegative-integer?) t-bl]
            [(list (? exact-nonnegative-integer?)) (list-ref ts t-bl)]))
    (when (and t-bl (not (memq t-bl ts)))
      (error "tblock-append: Cannot find baseline text-block in given list of text blocks"))
    (define bl (if (tblock? t-bl)
                 (+ (for/sum ([t (in-list ts)]
                              #:break (eq? t t-bl))
                      (tblock-height t))
                    (tblock-baseline t-bl))
                 t-bl)) ; number
    (lines->tblock (append-map tblock-lines ts) #:align align #:pad-char char #:baseline bl)))


;; strs: list of strings
;; rpos: (or/c 'top 'center 'bottom number? (list/c 'ratio number?))
;; cops: (or/c 'left 'center 'right number? (list/c 'ratio number?))
;; t2 is placed at (rpos cpos) relative to the top left corner of t1
(define (superimpose! t1 t2 rpos cpos)
  (let ([t1 (->tblock t1)]
        [t2 (->tblock t2)])
    (match-define (tblock w1 h1 b1 lines1) t1)
    (match-define (tblock w2 h2 b2 lines2) t2)
    (let ([cpos (cond [(number? cpos) cpos]
                      [(procedure? cpos) (cpos w1 w2)]
                      [(eq? cpos 'left) 0]
                      [(eq? cpos 'center) (quotient (- w1 w2) 2)]
                      [(eq? cpos 'right) (- w1 w2)])]
          [rpos (cond [(number? rpos) rpos]
                      [(procedure? rpos) (rpos h1 h2)]
                      [(eq? rpos 'top) 0]
                      [(eq? rpos 'center) (quotient (- h1 h2) 2)]
                      [(eq? rpos 'bottom) (- h1 h2)])])
      (for ([line-dest (in-list (drop lines1 (max 0 (min h1 rpos))))]
            [line-src  (in-list (drop lines2 (max 0 (min h2 (- rpos)))))]
            [row (in-range h1)])
        (string-copy! line-dest
                      (min (max cpos 0) w1 #;(- w1 1))
                      line-src
                      (min (max (- cpos) 0) w2 #;(- w2 1))
                      (max 0 (min w2 (- w1 cpos))))))))

(define (superimpose t1 t2 rpos cpos #:? [pad-char #\space])
  (let ([t1 (->tblock t1)] [t2 (->tblock t2)])
    (match-define (tblock w1 h1 b1 lines1) t1)
    (match-define (tblock w2 h2 b2 lines2) t2)
    (define t (lines->tblock (map string-copy lines1) #:baseline b1))
    (superimpose! t t2 rpos cpos)
    t))

(module+ test
  (check-equal? (tblock-lines
                 (superimpose (frame "You\nare\nawesome")
                                 "YOU\nARE"
                                 0 0))
                '("YOU─────┐"
                  "AREu    │"
                  "│are    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines
                 (superimpose (frame "You\nare\nawesome")
                                 "YOU\nARE"
                                 0 -1))
                '("OU──────┐"
                  "REou    │"
                  "│are    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines
                 (superimpose (frame "You\nare\nawesome")
                                 "YOU\nARE"
                                 -3 -3))
                '("┌───────┐"
                  "│You    │"
                  "│are    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines
                 (superimpose (frame "You\nare\nawesome")
                                 "YOU\nARE"
                                 1 1))
                '("┌───────┐"
                  "│YOU    │"
                  "│ARE    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines
                 (superimpose (frame "You\nare\nawesome")
                                 "YOU\nARE"
                                 4 7))
                '("┌───────┐"
                  "│You    │"
                  "│are    │"
                  "│awesome│"
                  "└──────YO"))
  (check-equal? (tblock-lines (superimpose (frame "You\nare\nawesome")
                                           "YOU\nARE"
                                           'bottom 'right))
                '("┌───────┐"
                  "│You    │"
                  "│are    │"
                  "│awesoYOU"
                  "└─────ARE"))
  (check-equal? (tblock-lines (superimpose (frame "You\nare\nawesome")
                                           "YOU\nARE"
                                           'top 'center))
                '("┌──YOU──┐"
                  "│YoARE  │"
                  "│are    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines (superimpose (frame "You\nare\nawesome")
                                           "YOU\nARE"
                                           'top 'right))
                '("┌─────YOU"
                  "│You  ARE"
                  "│are    │"
                  "│awesome│"
                  "└───────┘"))
  (check-equal? (tblock-lines (superimpose (frame "You\nare\nawesome")
                                           "YOU\nARE"
                                           'center 'center))
                '("┌───────┐"
                  "│YoYOU  │"
                  "│arARE  │"
                  "│awesome│"
                  "└───────┘"))
  )

;; The center element is used for the inset
(define styles
  '([single . ("┌─┐"
               "│ │"
               "└─┘")]
    [round  . ("╭─╮"
               "│ │"
               "╰─╯")]
    [double . ("╔═╗"
               "║ ║"
               "╚═╝")]
    [heavy  . ("┏━┓"
               "┃ ┃"
               "┗━┛")]))

(define frame-style/c
  (or/c (apply one-of/c (map car styles))
        (list/c string? string? string?)))

(define (frame t #:? [style 'single] #:? [inset 0])
  (let ([t (->tblock t)])
    (match-define (tblock w h baseline lines) t)
    (match-define `((,tl ,tc ,tr)
                    (,cl ,cc ,cr)  ; ,cc used for inset
                    (,bl ,bc ,br))
      (map string->list (dict-ref styles style style)))
    (lines->tblock
     (append
      (list (string-append (string tl)
                           (make-string (+ w (* 2 inset)) tc)
                           (string tr)))
      (make-list inset (string-append (string cl)
                                      (make-string (+ w (* 2 inset)) cc)
                                      (string cr)))
      (map (λ (line)
             (string-append (string cl)
                            (make-string inset cc)
                            line
                            (make-string inset cc)
                            (string cr)))
           lines)
      (make-list inset (string-append (string cl)
                                      (make-string (+ w (* 2 inset)) cc)
                                      (string cr)))
      (list (string-append (string bl)
                           (make-string (+ w (* 2 inset)) bc)
                           (string br))))
     #:baseline (+ baseline 1 inset))))

(module+ drracket
  (require "text.rkt")
  (define lorem-ipsum
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  (displayln
   (superimpose
    (frame
     (happend
      #:align 'center
      (lines->tblock (text->lines
                    (string-append
                     "Here's some justified text: "
                     lorem-ipsum " " lorem-ipsum)
                    35
                    #:align 'justified))
      (vappend
       #:align 'center
       (happend
        (frame
         (lines->tblock
          #:align 'left
          '("This text is" "#:align 'left" "and" "`frame`d with" "#:style 'round"))
         #:style 'round)
        (frame
         (lines->tblock
          #:align 'right
          '("This text is" "#:align 'right" "and" "`frame`d with" "#:style 'double"
                           "and #:inset 2"))
         #:style 'double #:inset 2)
        #:align 'top)
       (frame
        (lines->tblock
         '("This text is" "#:align 'center" "and" "`frame`d with" "#:style 'single")
         #:align 'center)))))
    (frame "YOU\nARE\nAWESOME")
    48 14)))

(define (make-line-like t style)
  (define ch
    (case style
      [(single) #\─]
      [(double) #\═]
      [(heavy) #\━]
      [else (if (char? style)
              style
              (error "invalid style: expected (or/c 'single 'double 'heavy char?), given "
                     style))]))
  (make-string (tblock-width t) ch))

(define (overline t #:? [style 'single])
  (let ([t (->tblock t)])
    (vappend (make-line-like t style)
             t
             #:baseline-of t)))

(define (underline t #:? [style 'single])
  (let ([t (->tblock t)])
    (vappend t
             (make-line-like t style)
             #:baseline-of t)))

(module+ test
  (check-equal? (tblock->string (underline "abc"))
                "abc\n───")
  (check-equal? (tblock->string (underline ""))
                "")
  (check-equal? (tblock->string (overline "abc" #:style 'heavy))
                "━━━\nabc"))

(define (vflip t)
  (let ([t (->tblock t)])
    (lines->tblock (reverse (tblock-lines t)) #:baseline (tblock-baseline t))))

(define (hflip t)
  (let ([t (->tblock t)])
    (lines->tblock (map string-reverse (tblock-lines t)) #:baseline (tblock-baseline t))))

(module+ test
  (check-equal? (tblock-lines (vflip "ab\nAB"))
                '("AB" "ab"))
  (check-equal? (tblock-lines (hflip "ab\nAB"))
                '("ba" "BA")))

