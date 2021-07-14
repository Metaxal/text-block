text-block
==========
Render math equations written in Racket as 2D unicode.

*Current status:* Request for comments (RFC). All suggestions and bug reports are welcome.
In RFC status, backward compatibility is not guaranteed so as to for getting rid of bad initial decisions.

The following code:
```racket
#lang racket
(require text-block)


(displayln
 (happend
  #:align 'baseline
  ($product #;$sum "x = 1" ($floor ($+ ($/ ($sqr "X") "2") "3")))
  "exp"
  ($brace ($/ ($sqrt
               ($+ (happend
                    "log"
                    ($paren ($/ (happend ($/ 2 3) " x + " @2/3 "y")
                                (happend "bx" @^- @^1 "-3"))))
                   (happend
                    ($integral "3y" @infty)
                    (happend
                     ($/ (happend "a" ($sqr "x") "+2")
                         (happend "bx" @^3 "-3"))
                     " dx"))
                   "2x+3"))
              ($+ ($/ (happend "ax" @^- @^2 "+2")
                      (happend "bx" @^4 "-3"))
                  ($/ ($ceiling
                       ($/ "ax²+2"
                           "bx³-3"))
                      ($paren (happend ($sum "n=1" "N") "log" @_2 " n"))))))))
```
produces this output (the Markdown CSS style cannot be changed, so this may render poorly):
```
            ⎧ ___________________________________⎫
            ⎪ ▏   ⎛2       ⎞                     ⎪
⎢X²    ⎥    ⎪ ▏   ⎜─ x + ⅔y⎟   ∞                 ⎪
⎢── + 3⎥    ⎪ ▏   ⎜3       ⎟   ⎧  ax²+2          ⎪
⎣2     ⎦    ⎪ ▏log⎜────────⎟ + ⎪  ───── dx + 2x+3⎪
  ▁▁▁▁      ⎪ ▏   ⎝ bx⁻¹-3 ⎠   ⎭  bx³-3          ⎪
   ⎜⎟       ⎪╲▏                3y                ⎪
   ⎜⎟    exp⎨────────────────────────────────────⎬
 x = 1      ⎪                  ⎡ax²+2⎤           ⎪
            ⎪                  ⎢─────⎥           ⎪
            ⎪       ax⁻²+2     ⎢bx³-3⎥           ⎪
            ⎪       ────── + ────────────        ⎪
            ⎪       bx⁴-3    ⎛ N        ⎞        ⎪
            ⎪                ⎜▁▁▁       ⎟        ⎪
            ⎪                ⎜╲         ⎟        ⎪
            ⎪                ⎜╱   log₂ n⎟        ⎪
            ⎪                ⎜▔▔▔       ⎟        ⎪
            ⎩                ⎝n=1       ⎠        ⎭
```
Here's what it looks like with proper rendering:

![equation](img/eq-screenshot.png)

To obtain this result in DrRacket, uncheck
`Preferences|Editing|General Editing|Add one pixel of extra space between lines`.
 
For good HTML/CSS rendering, you can use the [included style](example.css).


