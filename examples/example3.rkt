#lang racket
(require text-block)
  
(define lorem-ipsum
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
(displayln
 (frame
  (vappend
   #:align 'center
   " "
   "The Squirrel and The Fox"
   "A tale of two tails"
   " "
   (happend
    #:align 'top
    (make-tblock
     (text->lines
      #:align 'justified
      (string-append "Here's some justified text: " lorem-ipsum " " lorem-ipsum)
      35))
    " "
    (vappend
     #:align 'center
     (happend
      (frame
       (make-tblock
        #:align 'left
        '("This text is" "#:align 'left" "and" "`frame`d with" "#:style 'round"))
       #:style 'round)
      (frame
       (make-tblock
        #:align 'right
        '("This text is" "#:align 'right" "and" "`frame`d with" "#:style 'double"
                         "and #:inset 2"))
       #:style 'double #:inset 2)
      #:align 'top)
     (frame
      (make-tblock
       '("This text is" "#:align 'center" "and" "`frame`d with" "#:style 'single")
       #:align 'center))
     " "
     "The squirrel has saved as many acorns as"
     " "
     (happend
      "log"
      ($paren
       ($sum "n = 0" ($floor ($/ "N(N+1)" 2)))
       "n(n+1)"))))
   " "
   (happend "The " (underline "fox") "'s diet is pretty tight:")
   (happend
    2 ($sqrt "T") " - 2"
    " " @leq " "
    ($_^ ($square-bracket 2 ($sqrt "t")) "t=1" "T")
    " = "
    ($integral "t=1" "T") ($/ 1 ($sqrt "t")) " dt"
    " " @leq " "
    ($sum "t=1" "T") ($/ 1 ($sqrt "t"))
    " " @leq " "
    ($integral "t=0" "T-1") ($/ 1 ($sqrt "t")) " dt"
    " = "
    ($_^ ($square-bracket 2 ($sqrt "t")) "t=0" "T-1")
    " " @leq " "
    2 ($sqrt "T")))))
