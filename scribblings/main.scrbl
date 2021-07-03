#lang scribble/manual

@(require (for-label text-block))

@title{Text block}
@author{Laurent orseau}
@defmodule[text-block]

@bold{Note:} The HTML renderer of your browser may not render verbatim unicode optimally.
A better rendering will often be obtained in a fixed-size programming editor.
In DrRacket, to avoid intermediate blank pixel lines, uncheck
@tt{Edit|Preferences…|Editing|General Editing|Add one pixel of extra space between lines}.

You can also copy/paste unicode outputs @hyperlink["https://www.w3schools.com/code/tryit.asp?filename=GS5GOG5AUN8G"]{here} for a (usually) good preview.

@table-of-contents[]

@include-section[(lib "text-block/scribblings/datatype.scrbl")]
@include-section[(lib "text-block/scribblings/combiners.scrbl")]
@include-section[(lib "text-block/scribblings/justify.scrbl")]
@include-section[(lib "text-block/scribblings/math.scrbl")]
