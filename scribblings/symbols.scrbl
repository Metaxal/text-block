#lang scribble/manual

@(require (for-label text-block/text
                     text-block/symbols
                     racket/base)
          (submod text-block/symbols codes)
          text-block/symbols
          racket/base
          "example.rkt")

@;(define the-eval (make-eval 'text-block))
@(require scribble/example)

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

By default, symbols have a different prefix than functions exported by @racketmodname[text-block/math]
to avoid name collisions.



@(require (for-syntax (submod text-block/symbols codes)
                      racket/base
                      racket/syntax)
          scribble/private/manual-bind
          syntax/parse/define)

@(define-syntax (symbol-defs stx)
   (syntax-parse stx
     [(_)
      (with-syntax ([((id str) ...)
                     (hash-map codes
                               (λ (a b) (list (format-id stx #:source stx
                                                         "@~a" a)
                                              b)))])
        #'(list (list #'id str) ...
            #;(list (defidentifier #'id) str "\n")
            #;...))]))

@; TODO: use same 'example' style to have the same font?
The full list of symbols:
@;{(tabular
  #:sep @hspace[2]
  (cons
   (list @indexed-racket[|@mu|] "µ" "\n")
   (for/list ([p (in-list (sort (hash->list codes) string<? #:key car))])
    (define id-str (car p))
    (define id (string->symbol (string-append "@" id-str)))
    (define str (cdr p))
    (list @indexed-racket[#,id] str "\n"))))}
@(tabular
  #:sep @hspace[2]
  (for/list ([p (in-list (sort (symbol-defs) symbol<? #:key (λ (p) (syntax-e (car p)))))])
    (define id-stx (car p))
    (define str (cadr p))
    (list (elem (defidentifier id-stx)
                #:style "RktValLink") str "\n")))

