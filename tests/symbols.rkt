#lang racket/base

(require text-block/symbols
         (prefix-in § (submod text-block/symbols unprefixed))
         rackunit)

(check-equal? @zeta "ζ")
(check-equal? §zeta "ζ")
