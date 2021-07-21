#lang racket/base
(require define2
         racket/contract
         racket/list
         racket/string
         racket/math)

(provide
 (contract-out
  #:unprotected-submodule no-contract
  [make-list-of-k-sum-to-n (-> exact-positive-integer? exact-positive-integer? any)]
  [justify-line (->* [(listof string?) exact-positive-integer?]
                     [#:last-line? any/c]
                     any)]
  [align-line (-> (listof string?)
                  exact-positive-integer?
                  (one-of/c 'none 'left 'center 'align)
                  any)]
  [text->lines (->* [string? exact-positive-integer?]
                    [#:align (one-of/c 'none 'left 'center 'right 'justified)]
                    any)]
  [string-reverse (-> string? string?)]
  ))

(define (make-list-of-k-sum-to-n k n)
  (define-values (q r) (quotient/remainder n k))
  ; q = number of spaces at least per segment
  ; r = how many segments must have one more space
  (let loop ([res '()] [tot 0] [k-past 0])
    (cond [(= k-past k) (reverse res)]
          [(< (* (+ tot q)
                 (/ k (+ 1 k-past)))
              n)
           (loop (cons (+ q 1) res) (+ tot q 1) (+ k-past 1))]
          [else
           (loop (cons q res) (+ tot q) (+ k-past 1))])))

(module+ test
  (require rackunit)
  (for ([_i 100])
    (let* ([k (+ 1 (random 20))]
           [n (+ k (random 1000))])
      (define l (make-list-of-k-sum-to-n k n))
      (check-equal? (length l) k)
      (check-equal? (apply + l) n)
      (check-true (andmap nonnegative-integer? l))
      (check <= (- (apply max l) (apply min l)) 1))))

(define (justify-line strs ncol #:last-line? [last-line? #f])
  (cond [(or (empty? (rest strs))
             last-line?)
         (define s (string-join strs " "))
         (string-append s (make-string (max 0 (- ncol (string-length s))) #\space))]
        [else
         ;; add spaces in the middle so that the line is just the right size
         (string-append*
          (append-map
           list
           (cons "" (map (λ (len) (make-string len #\space))
                         (make-list-of-k-sum-to-n (- (length strs) 1)
                                                  (- ncol (apply + (map string-length strs))))))
           strs))]))

;; align: (one-of 'left 'center 'right 'none)
(define (align-line strs ncol align)
  (define s (string-join strs " "))
  (define n (max 0 (- ncol (string-length s))))
  (define-values (n-left n-right)
    (case align
      [(none) (values 0 0)]
      [(left) (values 0 n)]
      [(right) (values n 0)]
      [(center) (values (quotient n 2) (- n (quotient n 2)))]))
  (string-append (make-string n-left #\space)
                 s
                 (make-string n-right #\space)))

;; align: (one-of 'none 'left 'center 'right 'justified)
(define (text->lines text ncol #:align [align 'none])
  (define (format-line line [last-line? #f])
    (case align
      [(justified)
       (justify-line (reverse line) ncol #:last-line? last-line?)]
      [else
       (align-line (reverse line) ncol align)]))
  
  (let loop ([strs (string-split text #:repeat? #t)]
             [res '()]
             [line '()]
             [line-len 0])
    (if (empty? strs)
      (let ()
        #;(writeln (reverse line))
        (reverse (if (empty? line)
                   res
                   (cons (format-line line #t) res))))
      (let* ([str (first strs)]
             [rstrs (rest strs)]
             [str-len (string-length str)]
             [str-len±1 (+ str-len (if (empty? line) 0 1))]) ; + 1 for spaces between words
        (cond [(and (empty? line)
                    (> str-len ncol))
               ; A single word is too long for a line -> overflow
               (loop rstrs
                     ; close the current line
                     (cons (format-line (list str)) res)
                     ; start a new line
                     '()
                     0)]
              [(> (+ line-len str-len±1) ncol)
               (loop rstrs
                     ; close the current line
                     (cons (format-line line) res)
                     ; start a new line
                     (list str)
                     str-len)]
              [else
               (loop rstrs
                     res
                     ; continue the current line
                     (cons str line)
                     (+ line-len str-len±1))])))))

(module+ drracket
  (define lorem-ipsum
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  (text->lines lorem-ipsum 80 #:align 'justified)
  (text->lines lorem-ipsum 43 #:align 'justified)
  (text->lines lorem-ipsum 43 #:align 'left)
  (text->lines lorem-ipsum 43 #:align 'center)
  (text->lines lorem-ipsum 43 #:align 'right))

(module+ test
  (define lorem-ipsum
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
  
  ;; check string lengths, and total number of words
  (define (n-words . strs)
    (for/sum ([s (in-list strs)])
      (length (string-split s))))
  (define n-ipsum (n-words lorem-ipsum))
  (for ([ncol '(80 43 12 6 1)])
    (define ips1 (text->lines lorem-ipsum ncol #:align 'justified))
    (check-equal? (apply n-words ips1) n-ipsum)
    (for ([s (in-list ips1)])
      (when (> (n-words s) 1)
        (check-equal? (string-length s) ncol)))))

(define (string-reverse s)
  (apply string (reverse (string->list s))))
