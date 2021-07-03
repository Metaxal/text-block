#lang info
(define collection "text-block")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/main.scrbl" (multi-page) ("Text block") "text-block")))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(lorseau))
