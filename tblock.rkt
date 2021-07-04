#lang racket
(require define2)

;;; Text blocks that can be combined like pictures.

(provide (struct-out tblock)
         (all-defined-out)
         )

;;; any append operation creates a new rectangular block

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
(define (make-tblock lines
                     #:align [align 'left]
                     #:pad-char [char #\space]
                     #:baseline [baseline 0])
  (when (string? lines)
    (set! lines (string-split lines "\n" #:trim? #f)))
  (unless (andmap string? lines)
    (raise-argument-error 'make-tblock "(or/c string? (listof string?))" lines))
  (define w (apply max (map string-length lines)))
  (define h (length lines))
  (define new-lines
    (for/list ([line (in-list lines)] [i (in-naturals)])
      (match line
        [(list 'b (? string? str))
         (set! baseline i)]
        [else (void)])
      (string-pad line w align #:char char)))
  (tblock w h baseline new-lines))

(define (->tblock t)
  (cond [(tblock? t) t]
        [(string? t) (make-tblock t)]
        [else (make-tblock (~a t))]))

(define (valign-row t align)
  (let ([t (->tblock t)])
    (case align
      [(top) 0]
      [(bottom) (tblock-height t)]
      [(baseline) (tblock-baseline t)]
      [(center) (quotient (tblock-height t) 2)])))

;; align : (or/c 'top 'baseline 'bottom)
(define (happend #:align [align 'baseline] #:pad-char [char #\space]
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
    (make-tblock lines #:baseline htop)))

(define (vappend #:align [align 'left]
                        #:pad-char [char #\space]
                        #:baseline-of [t-bl #f]
                        . ts)
  (let ([ts (map ->tblock ts)])
    (when (and t-bl (not (memq t-bl ts)))
      (error "tblock-append: Cannot find baseline text-block in given list of text blocks"))
    (define bl (if t-bl
                 (+ (for/sum ([t (in-list ts)]
                              #:break (eq? t t-bl))
                      (tblock-height t))
                    (tblock-baseline t-bl))
                 0))
    (make-tblock (append-map tblock-lines ts) #:align align #:pad-char char #:baseline bl)))


;; rpos: (or/c 'top 'center 'bottom number? (list/c 'ratio number?))
;; cops: (or/c 'left 'center 'right number? (list/c 'ratio number?))
#;(define (superimpose t1 t2 rpos cpos)
  (let ([t1 (->tblock t1)] [t2 (->tblock t2)])
    (match-define (tblock w1 h1 b1 lines1) t1)
    (match-define (tblock w2 h2 b2 lines2) t2)
    (define r
      (match rpos
        ['top 0]
        ['center (quotient (/ (- h1 h2) 2))]
        ['bottom (- h1 h2)]
        [(list 'ratio (? number? ratio))
         (exact-round (* ratio (* (- h1 h2) ratio)))]
        [(? number?) rpos]))
    (define c
      (match cpos
        ['left 0]
        ['center (quotient (/ (- w1 w2) 2))]
        ['right (- w1 w2)]
        [(list 'ratio (? number? ratio))
         (exact-round (* ratio (* (- h1 h2) ratio)))]
        [(? number?) cpos]))
    (define w3 ())
    (define h3 ())
    (define lines3
      (for/list ([])))
    ))

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
               "╚═╝")]))

(define frame-style/c
  (or/c (one-of/c 'single 'round 'double)
        (list/c string? string? string?)))

;; style: (one-of 'single 'round 'double frame-style/c)
(define (frame t #:style [style 'single] #:inset [inset 0])
  (let ([t (->tblock t)])
    (match-define (tblock w h baseline lines) t)
    (match-define `((,tl ,tc ,tr)
                    (,cl ,cc ,cr)  ; ,cc used for inset
                    (,bl ,bc ,br))
      (map string->list (dict-ref styles style style)))
    (make-tblock
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
   (frame
    (happend
     #:align 'center
     (make-tblock (text->lines
                   (string-append
                    "Here's some justified text: "
                    lorem-ipsum " " lorem-ipsum)
                   35
                   #:align 'justified))
     (vappend
      #:align 'center
      (happend
       (frame
        (make-tblock
         #:align 'left
         '("This text is" "#:align 'left" "and" "`frame`d with" "#:style 'round"))
        #:style 'round)
       (frame
        (make-tblock
         #:align 'right
         '("This text is" "#:align 'right" "and" "`frame`d with" "#:style 'double"
                          "and #:inset 2"))
        #:style 'double #:inset 2)
       #:align 'top)
      (frame
       (make-tblock
        '("This text is" "#:align 'center" "and" "`frame`d with" "#:style 'single")
        #:align 'center)))))))


