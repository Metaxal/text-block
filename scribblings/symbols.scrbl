#lang scribble/manual

@(require (for-label text-block/text
                     racket/base)
          (submod text-block/symbols codes)
          racket/base
          "example.rkt")

@;(define the-eval (make-eval 'text-block))
@(require scribble/example)
@;examples[#:eval the-eval #:hidden (require text-block)]

@title{Text block: Unicode symbols}
@defmodule[#:multi
 (text-block/symbols
  (submod text-block/symbols unprefixed)
  (submod text-block/symbols codes))]

The @racket[text-block/symbols] module and its submodules provide bindings and a dictionary
to many unicode symbols:
@examples[#:label #f
 (require text-block/symbols)
 |@zeta|]
The default prefix is @racketid[|@|]. To change it, use the @racketid[unprefixed] submodule:
@examples[#:label #f
 (require (prefix-in ¶ (submod text-block/symbols unprefixed)))
 ¶zeta]
To access the underlying hash table, use the @racketid[codes] submodule:
@examples[#:label #f
 (require (submod text-block/symbols codes))
 (hash-ref codes "zeta")]

@; TODO: use same 'example' style to have the same font?
@; TODO: index all these elements without defining them with defthing?
The full list of symbols:
@(tabular
  #:sep @hspace[2]
  (for/list ([p (in-list (sort (hash->list codes) string<? #:key car))])
    (define id (car p))
    (define str (cdr p))
    (list @racket[#,str] "\n")))