#lang racket/base

(require define2
         scribble/example
         scribble/core
         scribble/manual
         scribble/html-properties
         racket/runtime-path
         racket/sandbox
         (for-syntax racket/base syntax/parse))

(define-runtime-path base-dir "..")

(provide (all-defined-out))

(define example-style
   (make-style "example"
               (list (make-css-addition (build-path base-dir "example.css")))
               #;(list (make-css-addition "../example.css"))))

(define (make-eval . mods) ; mods ignored for now
  (define ev (make-base-eval))
  ((scribble-eval-handler)
   ev
   #f
   `(require racket/port ,@mods))
  ev)

;; Better formatting for unicode 2d text
(define-syntax (display-example stx)
  (syntax-parse stx
    [(_ the-eval expr2 ...)
     #'(let ([eval the-eval])
         (list #;(para "Example:")
               (let* ()
                 (void (get-output eval)) ; discard
                 (define res
                   ((scribble-eval-handler)
                    eval
                    #f
                    'expr2))
                 (define str (get-output eval))
                 (list (racketinput expr2)
                       (if (void? res) '() (racketblock #,res))
                       (elem
                        #:style example-style
                        (list '() str))))
               ...))]))

(module+ drracket
  (define ev (make-eval 'text-block 'racket/string 'racket/port))
  (ev '(string-join '("+" "3" "2")))
  (ev '(happend "+" "3" "2"))
  (let ([scevha (scribble-eval-handler)])
    (parameterize ([sandbox-output (current-output-port)])
      (scevha ev #f '(displayln "yop"))))
  (displayln (get-output ev))
  (display-example ev (displayln (happend "+" "3" "2"))))
