#lang racket
(require define2
         "tblock.rkt")

(provide (all-defined-out))

;;; Find a unicode symbol: https://shapecatcher.com/

(define ($/ t1 . ts)
  (let-values ([(t1 t2)
                (if (empty? ts)
                  (values (->tblock 1)
                          (->tblock t1))
                  (if (empty? (rest ts))
                    (values (->tblock t1)
                            (->tblock (first ts)))
                    (values (->tblock t1)
                            (apply $* ts))))])
    (define w (max (tblock-width t1) (tblock-width t2)))
    (define new-t
      (vappend #:align 'center
                      t1
                      (lines->tblock (make-string w #\─))
                      t2))
    (set-tblock-baseline! new-t (tblock-height t1))
    new-t))

(define ($+ . ts)
  (apply happend
          #:align 'baseline
          (add-between ts " + ")))

(define ($- t . ts)
  (if (empty? ts)
    (happend "-" t)
    (apply happend
           #:align 'baseline
           (add-between (cons t ts) " - "))))

(define ($* . ts)
  (apply happend
         #:align 'baseline
         (let ([ts2
                (map (λ (t) (let ([t (->tblock t)])
                              (define s (tblock->string t))
                              (if (<= (string-length s) 1)
                                t
                                ($paren t))))
                     ts)])
           (add-between ts2 " "))))

;; TODO: No paren if fraction, or sqrt, or already paren'ed.
;; Should we keep the tblock hierarchy instead of reducing it immediately?
;; Then it could be manipulated at will and would retain information.
;; only the ->string would collapse it.
(define (maybe-paren t)
  (let ([t (->tblock t)])
    (if (and (<= (tblock-width t) 1)
             (<= (tblock-height t) 1))
      t
      ($paren t))))

(define ($sqr t)
  (happend (maybe-paren t) "²"))

(define ($cube t)
  (happend (maybe-paren t) "³"))

(define ($expt t1 t2)
  (let ([t1 (maybe-paren (->tblock t1))] [t2 (->tblock t2)])
    ($^ t1 t2)))

(define ($^ t1 t2)
  (let ([t1 (->tblock t1)] [t2 (->tblock t2)])
    (define t3
      (vappend (happend (make-string (tblock-width t1) #\space) t2)
                      t1
                      #:align 'left))
    (set-tblock-baseline! t3 (+ (tblock-height t2) (tblock-baseline t1)))
    t3))

(define ($_ t1 t2)
  (let ([t1 (->tblock t1)] [t2 (->tblock t2)])
    (define t3
      (vappend t1
                      (happend (make-string (tblock-width t1) #\space) t2)
                      #:align 'left))
    (set-tblock-baseline! t3 (tblock-baseline t1))
    t3))

(define ($^_ t1 t^ t_)
  (let ([t1 (->tblock t1)] [t^ (->tblock t^)])
    (define t3
      (vappend (happend (make-string (tblock-width t1) #\space) t^)
                      t1
                      (happend (make-string (tblock-width t1) #\space) t_)
                      #:align 'left))
    (set-tblock-baseline! t3 (+ (tblock-height t^) (tblock-baseline t1)))
    t3))

(define ($_^ t1 t_ t^)
  ($^_ t1 t^ t_))

;; Takes an operator tblock or multiline string and
;; returns a function that takes a below and above tblocks and returns
;; a tblock that vappends them and adds a space.
;; See tblock-sum for an example.
(define ((make-operator tsym) below above)
  (let ([below (->tblock below)] [above (->tblock above)])
    (happend
     (vappend
      #:align 'center
      #:baseline-of tsym
      above
      tsym
      below)
     " ")))

;; https://en.wikipedia.org/wiki/Miscellaneous_Technical#Block
(define $sum
  (make-operator
   (lines->tblock
    "\
▁▁▁
╲
╱
▔▔▔"
    #:baseline 2)))

(define $product
  (make-operator
   (lines->tblock
    "\
▁▁▁▁
 ⎜⎟ 
 ⎜⎟ "
    #:baseline 2)))

;; Should the integral scale with the height of a given tblock?
(define $integral
  (make-operator
   (lines->tblock
"\
⎧
⎪
⎭"
    #:baseline 1)))

(define ($sqrt t)
  (let ([t (->tblock t)])
    (define h (tblock-height t))
    (define w (tblock-width t))
    (define t2
      (vappend
       #:align 'left
       (string-append " " (make-string (+ w 1) #;#\_ #\▁ #;#\⎯))
       (happend
        #:align 'bottom
        (string-join (append (make-list (- h 1) " ▏")
                             (list "╲▏"))
                     "\n")
        t)))
    (set-tblock-baseline! t2 (+ 1 (tblock-baseline t)))
    t2))

;; strs-odd has 5 elements
;; strs-even can have either 5 or 6 elements
(define ((make-vertical-bracket str1 strs2 strs-odd [strs-even strs-odd]) t)
  (let ([t (->tblock t)])
    (define h (tblock-height t))
    (define b (tblock-baseline t))
    #;(writeln t)
    (cond [(= 0 h) (->tblock "")]
          [(= 1 h) (->tblock str1)]
          [(= 2 h) (lines->tblock (string-join strs2 "\n") #:baseline b)]
          [(odd? h)
           (match strs-odd
             [(list top top-mid center bot-mid bottom)
              (define n-top-mid (min (- h 3)
                                     (max 0 (- b 1))))
              (define n-bot-mid (max 0 (- h n-top-mid 3)))
              (lines->tblock
               (string-join
                (append (list top)
                        (make-list n-top-mid top-mid)
                        (list center)
                        (make-list n-bot-mid bot-mid)
                        (list bottom))
                "\n")
               #:baseline b)])]
          [else ;(even? h)
           (match strs-even
             [(list top top-mid center bot-mid bottom)
              (define n-top-mid (min (- h 3)
                                     (max 0 (- b 1))))
              (define n-bot-mid (- h n-top-mid 3))
              (lines->tblock
               (string-join
                (append (list top)
                        (make-list n-top-mid top-mid)
                        (list center)
                        (make-list n-bot-mid bot-mid)
                        (list bottom))
                "\n")
               #:baseline b)]
             [(list top top-mid top-center bot-center bot-mid bottom)
              ; special treatment: two symbols are used at the center
              (lines->tblock
               (string-join
                (append (list top)
                        (make-list (max 0 (- b 2)) top-mid)
                        (list top-center bot-center)
                        (make-list (max 0 (- h b 4)) bot-mid)
                        (list bottom))
                "\n")
               #:baseline b)])])))

(define (make-bracketing make-left-bracket make-right-bracket)
  (values (λ ts (let ([t (apply happend (map ->tblock ts))])
                  (happend (make-left-bracket t) t)))
          (λ ts (let ([t (apply happend (map ->tblock ts))])
                  (happend t (make-right-bracket t))))
          (λ ts (let ([t (apply happend (map ->tblock ts))])
                  (happend (make-left-bracket t) t (make-right-bracket t))))))

(define-values ($left-brace $right-brace $brace)
  (make-bracketing
   (make-vertical-bracket "{"  '("⎭" "⎫") '("⎧" "⎪" "⎨" "⎪" "⎩"))
   (make-vertical-bracket "}"  '("⎩" "⎧") '("⎫" "⎪" "⎬" "⎪" "⎭")))
  #;(make-bracketing
   (make-vertical-bracket "{"  '("⎰" "⎱") '("⎧" "⎪" "⎨" "⎪" "⎩"))
   (make-vertical-bracket "}"  '("⎱" "⎰") '("⎫" "⎪" "⎬" "⎪" "⎭")))
  #;(make-bracketing ; 2 symbols at the middle
   (make-vertical-bracket "{"  '("⎰" "⎱") '("⎧" "⎪" "⎨" "⎪" "⎩") '("⎧" "⎪" "⎭" "⎫" "⎪" "⎩"))
   (make-vertical-bracket "}"  '("⎱" "⎰") '("⎫" "⎪" "⎬" "⎪" "⎭") '("⎫" "⎪" "⎩" "⎧" "⎪" "⎭"))))

(define-values ($left-paren $right-paren $paren)
  (make-bracketing
   (make-vertical-bracket "("  '("⎛" "⎝") '("⎛" "⎜" "⎜" "⎜" "⎝"))
   (make-vertical-bracket ")"  '("⎞" "⎠") '("⎞" "⎟" "⎟" "⎟" "⎠"))))

(define-values ($left-square-bracket $right-square-bracket $square-bracket)
  (make-bracketing
   (make-vertical-bracket "["  '("⎡" "⎣") '("⎡" "⎢" "⎢" "⎢" "⎣"))
   (make-vertical-bracket "]"  '("⎤" "⎦") '("⎤" "⎥" "⎥" "⎥" "⎦"))))

(define-values ($left-ceiling $right-ceiling $ceiling)
  (make-bracketing
   (make-vertical-bracket "⌈"  '("⎡" "⎢") '("⎡" "⎢" "⎢" "⎢" "⎢"))
   (make-vertical-bracket "⌉"  '("⎤" "⎥") '("⎤" "⎥" "⎥" "⎥" "⎥"))))

(define-values ($left-floor $right-floor $floor)
  (make-bracketing
   (make-vertical-bracket "⌊"  '("⎢" "⎣") '("⎢" "⎢" "⎢" "⎢" "⎣"))
   (make-vertical-bracket "⌋"  '("⎥" "⎦") '("⎥" "⎥" "⎥" "⎥" "⎦"))))

(define ($underbrace t t_)
  ; (#\─      ("│" "│" "│") ("╭" "┬" "╮") ("├" "┼" "┤") ("╰" "┴" "╯"))
  (let ([t (->tblock t)] [t_ (->tblock t_)])
    (define w (tblock-width t))
    (define br
      (case w
        [(0) ""]
        [(1) "⏟"]
        [(2) "╰╯"]
        [else
         (define wl (quotient (- w 3) 2))
         (define wr (- w 3 wl))
         (happend "╰" (make-string wl #\─) "┬" (make-string wr #\─) "╯")]))
    (vappend t br t_ #:baseline-of t #:align 'center)))

(define ($overbrace t t^)
  ; (#\─      ("│" "│" "│") ("╭" "┬" "╮") ("├" "┼" "┤") ("╰" "┴" "╯"))
  (let ([t (->tblock t)] [t^ (->tblock t^)])
    (define w (tblock-width t))
    (define br
      (case w
        [(0) ""]
        [(1) "⏞"]
        [(2) "╭╮"]
        [else
         (define wl (quotient (- w 3) 2))
         (define wr (- w 3 wl))
         (happend "╭" (make-string wl #\─) "┴" (make-string wr #\─) "╮")]))
    (vappend t^ br t #:baseline-of t #:align 'center)))


(define (tree-apply t dic)
  (let loop ([t t])
    (cond [(and (list? t)
                (not (empty? (rest t))))
           (define op (dict-ref dic (first t) #f))
           (if op
             (apply op (map loop (rest t)))
             (happend
              (first t)
              ($paren (apply happend (add-between (map loop (rest t)) ", ")))))]
          [else
           t])))

(define formula-dict
  `((+ . ,$+)
    (- . ,$-)
    (* . ,$*)
    (^ . ,$expt)
    (/ . ,$/)
    (expt . ,$expt)
    (sqrt . ,$sqrt)
    (sqr . ,$sqr)
    (floor . ,$floor) (left-floor . ,$left-floor) (right-floor . ,$right-floor)
    (ceiling . ,$ceiling) (left-ceiling . ,$left-ceiling) (right-ceiling . ,$right-ceiling)
    (brace . ,$brace) (left-brace . ,$left-brace) (right-brace . ,$right-brace)
    (paren . ,$paren) (left-paren . ,$left-paren) (right-paren . ,$right-paren)
    (square-bracket . ,$square-bracket) (left-square-bracket . ,$left-square-bracket) (right-square-bracket . ,$right-square-bracket)
    (underbrace . ,$underbrace)))

(define ($formula tree [formula-dict formula-dict])
  (tree-apply tree formula-dict))


(module+ test
  (require rackunit)
  (let ()
    (define lines
      '("a if x > 1"
        "b if x < -1"
        "c if x = 0"
        "d if x = 1"
        "e if x = -1"))
    (for ([n (in-range 1 (+ 1 (length lines)))])
      (for ([b (in-range n)])
        (define t
          ($ceiling (happend "3x + "
                             ($left-brace (lines->tblock (take lines n) #:baseline b))
                             " ")))
        (check-equal? (tblock-height t) n)
        (check-equal? (tblock-baseline t) b)
        #;(displayln t))))
  (check-equal?
   ($formula '(floor (log (/ t_max t_0))))
   (tblock 12 3 1
           '("⎢   ⎛t_max⎞⎥"
             "⎢log⎜─────⎟⎥"
             "⎣   ⎝ t_0 ⎠⎦")))
  )
