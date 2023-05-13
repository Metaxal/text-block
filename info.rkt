#lang info
(define collection "text-block")
(define deps '("define2"
               "base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib" "sandbox-lib"))
(define scribblings '(("scribblings/main.scrbl" (multi-page) ("Text block") "text-block")))
(define pkg-desc "Combine unicode 2d text blocks, display unicode math formula")
(define version "0.0")
(define pkg-authors '(laurent.orseau@gmail.com))

(define compile-omit-paths '("wip"))
(define license '(Apache-2.0 OR MIT))