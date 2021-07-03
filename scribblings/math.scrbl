#lang scribble/manual
@require[@for-label[text-block
                    text-block/math
                    racket/contract
                    racket/base
                    racket/format]
         text-block
         text-block/math]

@title{Text block maths}

@defmodule[text-block/math]

@defproc*[([($+ [t tblock/any] ...) tblock?]
           [($/ [t tblock/any] ...) tblock?]
           [($* [t tblock/any] ...) tblock?]
           )
          ]{
Compose tblocks horizontally for arithmetic operations.}

