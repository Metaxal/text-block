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
      (tblock-vappend #:align 'center
                      t1
                      (make-tblock (make-string w #\─))
                      t2))
    (set-tblock-baseline! new-t (tblock-height t1))
    new-t))

(define ($+ . ts)
  (apply tblock-happend
          #:align 'baseline
          (add-between ts " + ")))

(define ($* . ts)
  (apply tblock-happend
         #:align 'baseline
         (let ([ts2
                (map (λ (t) (let ([t (->tblock t)])
                              (define s (tblock->string t))
                              (if (<= (string-length s) 1)
                                t
                                ($paren t))))
                     ts)])
           (add-between ts2 " "))))

#;(define (tblock-expt ))

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
  (tblock-happend (maybe-paren t) "²"))

(define ($^ t1 t2)
  (let ([t1 (maybe-paren (->tblock t1))] [t2 (->tblock t2)])
    (define t3
      (tblock-vappend (tblock-happend (make-string (tblock-width t1) #\space) t2)
                      t1
                      #:align 'left))
    (set-tblock-baseline! t3 (+ (tblock-height t2) (tblock-baseline t1)))
    t3))

(define ($_ t1 t2)
  (let ([t1 (->tblock t1)] [t2 (->tblock t2)])
    (define t3
      (tblock-vappend t1
                      (tblock-happend (make-string (tblock-width t1) #\space) t2)
                      #:align 'left))
    (set-tblock-baseline! t3 (tblock-baseline t1))
    t3))

(define ($^_ t1 t^ t_)
  (let ([t1 (maybe-paren (->tblock t1))] [t^ (->tblock t^)])
    (define t3
      (tblock-vappend (tblock-happend (make-string (tblock-width t1) #\space) t^)
                      t1
                      (tblock-happend (make-string (tblock-width t1) #\space) t_)
                      #:align 'left))
    (set-tblock-baseline! t3 (+ (tblock-height t^) (tblock-baseline t1)))
    t3))

;; Takes an operator tblock or multiline string and
;; returns a function that takes a below and above tblocks and returns
;; a tblock that vappends them and adds a space.
;; See tblock-sum for an example.
(define ((make-tblock-operator tsym) below above)
  (let ([below (->tblock below)] [above (->tblock above)])
    (tblock-happend
     (tblock-vappend
      #:align 'center
      #:baseline-of tsym
      above
      tsym
      below)
     " ")))

;; https://en.wikipedia.org/wiki/Miscellaneous_Technical#Block
(define $sum
  (make-tblock-operator
   (make-tblock
    "\
▁▁▁
╲
╱
▔▔▔"
    #:baseline 2)))

(define $product
  (make-tblock-operator
   (make-tblock
    "\
▁▁▁▁
 ⎜⎟ 
 ⎜⎟ "
    #:baseline 2)))

;; Should the integral scale with the height of a given tblock?
(define $integral
  (make-tblock-operator
   (make-tblock
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
      (tblock-vappend
       #:align 'left
       (string-append " " (make-string (+ w 1) #\▁))
       (tblock-happend
        #:align 'bottom
        (string-join (append (make-list (- h 1) " ▏")
                             (list "╲▏"))
                     "\n")
        t)))
    (set-tblock-baseline! t2 (+ 1 (tblock-baseline t)))
    t2))

(define ((make-vertical-bracket str1 strs2 strs-odd strs-even) t)
  (let ([t (->tblock t)])
    (define h (tblock-height t))
    (define b (tblock-baseline t))
    (cond [(= 1 h) str1]
          [(= 2 h) (make-tblock (string-join strs2 "\n") #:baseline b)]
          [(odd? h)
           (match strs-odd
             [(list top top-mid center bot-mid bottom)
              (make-tblock
               (string-join
                (append (list top)
                        (make-list (max 0 (- b 1)) top-mid)
                        (list center)
                        (make-list (max 0 (- h b 2)) bot-mid)
                        (list bottom))
                "\n")
               #:baseline b)])]
          [else #;(even? h)
           (match strs-even
             [(list top top-mid top-center bot-center bot-mid bottom)
                (make-tblock
                 (string-join
                  (append (list top)
                          (make-list (max 0 (- b 2)) top-mid)
                          (list top-center bot-center)
                          (make-list (max 0 (- h b 2)) bot-mid)
                          (list bottom))
                  "\n")
                 #:baseline b)])])))

(define (make-bracketing make-left-bracket make-right-bracket)
  (values (λ (t) (let ([t (->tblock t)])
                   (tblock-happend (make-left-bracket t) t #:align 'baseline)))
          (λ (t) (let ([t (->tblock t)])
                   (tblock-happend t (make-right-bracket t) #:align 'baseline)))
          (λ (t) (let ([t (->tblock t)])
                   (tblock-happend (make-left-bracket t) t (make-right-bracket t) #:align 'baseline)))))

;; WARNING: Naming inconsistence with tblock-sum
;; WARNING: Name clashes with normal racket
(define-values ($left-brace $right-brace $brace)
  (make-bracketing
   (make-vertical-bracket "{"  '("⎰" "⎱") '("⎧" "⎪" "⎨" "⎪" "⎩") '("⎧" "⎪" "⎪" "⎨" "⎪" "⎩"))
   (make-vertical-bracket "}"  '("⎱" "⎰") '("⎫" "⎪" "⎬" "⎪" "⎭") '("⎫" "⎪" "⎪" "⎬" "⎪" "⎭")))
  #;(make-bracketing
   (make-vertical-bracket "{"  '("⎰" "⎱") '("⎧" "⎪" "⎨" "⎪" "⎩") '("⎧" "⎪" "⎭" "⎫" "⎪" "⎩"))
   (make-vertical-bracket "}"  '("⎱" "⎰") '("⎫" "⎪" "⎬" "⎪" "⎭") '("⎫" "⎪" "⎩" "⎧" "⎪" "⎭"))))

(define-values ($left-paren $right-paren $paren)
  (make-bracketing
   (make-vertical-bracket "("  '("⎛" "⎝") '("⎛" "⎜" "⎜" "⎜" "⎝") '("⎛" "⎜" "⎜" "⎜" "⎜" "⎝"))
   (make-vertical-bracket ")"  '("⎞" "⎠") '("⎞" "⎟" "⎟" "⎟" "⎠") '("⎞" "⎟" "⎟" "⎟" "⎟" "⎠"))))

(define-values ($left-square-bracket $right-square-bracket $square-bracket)
  (make-bracketing
   (make-vertical-bracket "["  '("⎡" "⎣") '("⎡" "⎢" "⎢" "⎢" "⎣") '("⎡" "⎢" "⎢" "⎢" "⎢" "⎣"))
   (make-vertical-bracket "]"  '("⎤" "⎦") '("⎤" "⎥" "⎥" "⎥" "⎦") '("⎤" "⎥" "⎥" "⎥" "⎥" "⎦"))))

(define-values ($left-ceiling $right-ceiling $ceiling)
  (make-bracketing
   (make-vertical-bracket "⌈"  '("⎡" "⎢") '("⎡" "⎢" "⎢" "⎢" "⎢") '("⎡" "⎢" "⎢" "⎢" "⎢" "⎢"))
   (make-vertical-bracket "⌉"  '("⎤" "⎥") '("⎤" "⎥" "⎥" "⎥" "⎥") '("⎤" "⎥" "⎥" "⎥" "⎥" "⎥"))))

(define-values ($left-floor $right-floor $floor)
  (make-bracketing
   (make-vertical-bracket "⌊"  '("⎢" "⎣") '("⎢" "⎢" "⎢" "⎢" "⎣") '("⎢" "⎢" "⎢" "⎢" "⎢" "⎣"))
   (make-vertical-bracket "⌋"  '("⎥" "⎦") '("⎥" "⎥" "⎥" "⎥" "⎦") '("⎥" "⎥" "⎥" "⎥" "⎥" "⎦"))))

#;
(define (vphantom t))
(module+ drracket
  
  (displayln ($^ ($+ 1 ($* 2 'x 'α)) 3))

  (displayln
   (tblock-happend
     #:align 'baseline
     ($product #;sum "x=1" ($floor ($+ ($/ "X²" "2") "3")))
     "exp"
     ($brace ($/ ($sqrt
                  ($+ (tblock-happend
                       "log"
                       ($paren ($/ ($* ($/ 2 3) "x")
                                   "bx³-3")))
                      (tblock-happend
                       ($integral "3y" "∞")
                       (tblock-happend
                        ($/ "ax²+2"
                            "bx³-3")
                        " dx"))
                      "2x+3"))
       ($+ ($/ "ax²+2"
               "bx³-3")
           ($/ ($square-bracket
                ($/ "ax²+2"
                    "bx³-3"))
               ($paren (tblock-happend ($sum "n=1" "N") "log(n)")))))))))

