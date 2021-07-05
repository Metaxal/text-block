#lang scribble/manual

@(require (for-label text-block/text
                     racket/base)
          (submod text-block/symbols codes)
          racket/base
          scribble/example)

@title{Text block: Unicode symbols}
@defmodule[#:multi
 (text-block/symbols
  (submod text-block/symbols unprefixed)
  (submod text-block/symbols codes))]

The @racket[text-block/symbols] module and its submodules provide bindings and a dictionary
to many unicode symbols:
@examples[#:eval (make-base-eval) #:label #f
          (require text-block/symbols)
          |@zeta|]
The default prefix is @racketid[|@|]. To change it, use the @racketid[unprefixed] submodule:
@examples[#:eval (make-base-eval) #:label #f
          (require (prefix-in ¶ (submod text-block/symbols unprefixed)))
          ¶zeta]
To access the underlying hash table, use the @racketid[codes] submodule:
@examples[#:eval (make-base-eval) #:label #f
          (require (submod text-block/symbols codes))
          (hash-ref codes "zeta")]

The full list of symbols:
@(tabular
  #:sep @hspace[2]
  (for/list ([p (in-list (sort (hash->list codes) string<? #:key car))])
    (define id (car p))
    (define str (cdr p))
    (list id @racket[#,str] "\n")))