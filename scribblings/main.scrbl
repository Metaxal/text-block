#lang scribble/manual

@(require (for-label text-block))

@title{Text block}
@author{Laurent Orseau}
@defmodule[text-block]

@bold{Note:} In DrRacket, to avoid intermediate blank pixel lines, uncheck
@tt{Edit|Preferences…|Editing|General Editing|Add one pixel of extra space between lines}.

@table-of-contents[]

@include-section[(lib "text-block/scribblings/datatype.scrbl")]
@include-section[(lib "text-block/scribblings/combiners.scrbl")]
@include-section[(lib "text-block/scribblings/text.scrbl")]
@include-section[(lib "text-block/scribblings/math.scrbl")]
@include-section[(lib "text-block/scribblings/symbols.scrbl")]
