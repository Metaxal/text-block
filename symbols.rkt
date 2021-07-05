#lang racket/base

(module codes racket/base
  (provide codes)
  (define codes
    #hash(
          ["lt"           . "\u3C"]    ; < LESS THAN
          ["gt"           . "\u3E"]    ; > GREATER THAN
          ["le"           . "\u2264"]  ; ≤ LESS THAN OR EQUAL TO
          ["ge"           . "\u2265"]  ; ≥ GREATER THAN OR EQUAL TO
          ["plusmn"       . "\uB1"]    ; ± PLUS OR MINUS
          ["ne"           . "\u2260"]  ; ≠ NOT EQUALS
          ["divide"       . "\uF7"]    ; ÷ DIVISION SIGN
          ["times"        . "\u00D7"]  ; × TIMES X
          ["minus"        . "\u2212"]  ; − MINUS
          ["div"          . "\u2215"]  ; ∕ DIVISION SLASH
          ["frasl"        . "\u2044"]  ; ⁄ FRACTION SLASH
          ["radic"        . "\u221A"]  ; √ SQUARE ROOT RADICAL
          ["sqrt"         . "\u221A"]  ; √ SQUARE ROOT RADICAL
          ["root"         . "\u221A"]  ; √ SQUARE ROOT RADICAL
          ["squareroot"   . "\u221A"]  ; √ SQUARE ROOT RADICAL
          ["cuberoot"     . "\u221B"]  ; ∛ CUBE ROOT
          ["fourthroot"   . "\u221C"]  ; ∜ FOURTH ROOT
          ["infty"        . "\u221E"]  ; ∞ INFINITY 
          ["infin"        . "\u221E"]  ; ∞ INFINITY
          ["fnof"         . "\u192"]   ; ƒ FUNCTION ITALIC F
          ["prime"        . "\u2032"]  ; ′ PRIME (single quote)
          ["Prime"        . "\u2033"]  ; ″ DOUBLE PRIME (double quote)
          ["tripleprime"  . "\u2034"]  ; ‴ TRIPLE PRIME (triple quote)
          ["there4"       . "\u2234"]  ; ∴ THEREFORE (Triangular Dots)
          ["sdot"         . "\u22C5"]  ; ⋅ DOT OPERATOR
          ["sup0"         . "\u2070"]  ; ₀ SUPERSCRIPT ZERO
          ["^0"           . "\u2070"]  ; ₀ SUPERSCRIPT ZERO
          ["sup1"         . "\uB9"]    ; ¹ SUPERSCRIPT ONE
          ["^1"           . "\uB9"]    ; ¹ SUPERSCRIPT TWO
          ["sup2"         . "\uB2"]    ; ² SUPERSCRIPT TWO
          ["^2"           . "\uB2"]    ; ² SUPERSCRIPT TWO
          ["sup3"         . "\uB3"]    ; ³ SUPERSCRIPT THREE
          ["^3"           . "\uB3"]    ; ³ SUPERSCRIPT THREE
          ["sup4"         . "\u2074"]  ; ⁴ SUPERSCRIPT FOUR
          ["^4"           . "\u2074"]  ; ⁴ SUPERSCRIPT FOUR
          ["sup5"         . "\u2075"]  ; ⁵ SUPERSCRIPT FIVE
          ["^5"           . "\u2075"]  ; ⁵ SUPERSCRIPT FIVE
          ["sup6"         . "\u2076"]  ; ⁶ SUPERSCRIPT SIX
          ["^6"           . "\u2076"]  ; ⁶ SUPERSCRIPT SIX
          ["sup7"         . "\u2077"]  ; ⁷ SUPERSCRIPT SEVEN
          ["^7"           . "\u2077"]  ; ⁷ SUPERSCRIPT SEVEN
          ["sup8"         . "\u2078"]  ; ⁸ SUPERSCRIPT EIGHT
          ["^8"           . "\u2078"]  ; ⁸ SUPERSCRIPT EIGHT
          ["sup9"         . "\u2079"]  ; ⁹ SUPERSCRIPT NINE
          ["^9"           . "\u2079"]  ; ⁹ SUPERSCRIPT NINE
          ["sub0"         . "\u2080"]  ; ₀ SUBSCRIPT ZERO
          ["_0"           . "\u2080"]  ; ₀ SUBSCRIPT ZERO
          ["sub1"         . "\u2081"]  ; ₁ SUBSCRIPT ONE
          ["_1"           . "\u2081"]  ; ₁ SUBSCRIPT ONE
          ["sub2"         . "\u2082"]  ; ₂ SUBSCRIPT TWO
          ["_2"           . "\u2082"]  ; ₂ SUBSCRIPT TWO
          ["sub3"         . "\u2083"]  ; ₃ SUBSCRIPT THREE
          ["_3"           . "\u2083"]  ; ₃ SUBSCRIPT THREE
          ["sub4"         . "\u2084"]  ; ₄ SUBSCRIPT FOUR
          ["_4"           . "\u2084"]  ; ₄ SUBSCRIPT FOUR
          ["sub5"         . "\u2085"]  ; ₅ SUBSCRIPT FIVE
          ["_5"           . "\u2085"]  ; ₅ SUBSCRIPT FIVE
          ["sub6"         . "\u2086"]  ; ₆ SUBSCRIPT SIX
          ["_6"           . "\u2086"]  ; ₆ SUBSCRIPT SIX
          ["sub7"         . "\u2087"]  ; ₇ SUBSCRIPT SEVEN
          ["_7"           . "\u2087"]  ; ₇ SUBSCRIPT SEVEN
          ["sub8"         . "\u2088"]  ; ₈ SUBSCRIPT EIGHT
          ["_8"           . "\u2088"]  ; ₈ SUBSCRIPT EIGHT
          ["sub9"         . "\u2089"]  ; ₉ SUBSCRIPT NINE
          ["_9"           . "\u2089"]  ; ₉ SUBSCRIPT NINE
          ["^+"           . "\u207A"]  ; ⁺
          ["^-"           . "\u207B"]  ; ⁻
          ["^="           . "\u207C"]  ; ⁼
          ["^("           . "\u207D"]  ; ⁽
          ["^)"           . "\u207E"]  ; ⁾
          ["_+"           . "\u208A"]  ; ₊
          ["_-"           . "\u208B"]  ; ₋
          ["_="           . "\u208C"]  ; ₌
          ["_("           . "\u208D"]  ; ₍
          ["_)"           . "\u208E"]  ; ₎
          ["lang"         . "\u2329"]  ; ⟨ LEFT ANGLE BRACKET
          ["langle"       . "\u2329"]
          ["rang"         . "\u232A"]  ; ⟩ RIGHT ANGLE BRACKET
          ["rangle"       . "\u232A"]
          ["lceil"        . "\u2308"]  ; ⌈ LEFT CEILING BRACKET
          ["rceil"        . "\u2309"]  ; ⌉ RIGHT CEILING BRACKET
          ["lfloor"       . "\u230A"]  ; ⌊ LEFT FLOOR BRACKET
          ["rfloor"       . "\u230B"]  ; ⌋ RIGHT FLOOR BRACKET

          ["1/4"  . "\uBC"]    ; ¼ VULGAR FRACTION 1/4
          ["1/2"  . "\uBD"]    ; ½ VULGAR FRACTION 1/2
          ["3/4"  . "\uBE"]    ; ¾ VULGAR FRACTION 3/4
          ["1/3"  . "\u2153"]  ; ⅓ VULGAR FRACTION 1/3
          ["2/3"  . "\u2154"]  ; ⅔ VULGAR FRACTION 2/3
          ["1/5"  . "\u2155"]  ; ⅕ VULGAR FRACTION 1/5
          ["2/5"  . "\u2156"]  ; ⅖ VULGAR FRACTION 2/5
          ["3/5"  . "\u2157"]  ; ⅗ VULGAR FRACTION 3/5
          ["4/5"  . "\u2158"]  ; ⅘ VULGAR FRACTION 4/5
          ["1/6"  . "\u2159"]  ; ⅙ VULGAR FRACTION 1/6
          ["5/6"  . "\u215A"]  ; ⅚ VULGAR FRACTION 5/6
          ["1/8"  . "\u215B"]  ; ⅛ VULGAR FRACTION 1/8
          ["3/8"  . "\u215C"]  ; ⅜ VULGAR FRACTION 3/8
          ["5/8"  . "\u215D"]  ; ⅝ VULGAR FRACTION 5/8
          ["7/8"  . "\u215E"]  ; ⅞ VULGAR FRACTION 7/8

          ["int"       . "\u222B"]  ; ∫ INTEGRAL
          ["integral"  . "\u222B"]
          ["part"      . "\u2202"]  ; ∂ PARTIAL DIFFERENTIAL
          ["partial"   . "\u2202"]
          ["Diff"      . "\u2206"]  ; Δ INCREMENT (Difference or capital Delta)
          ["nabla"     . "\u2207"]  ; ∇ NABLA (Backward Difference, Grad or upside down triangle)
          ["iint"      . "\u222C"]  ; ∬ DOUBLE INTEGRAL
          ["iiint"     . "\u222D"]  ; ∭ TRIPLE INTEGRAL
          ["iiiint"    . "\u2A0C"]  ; ⨌ QUADRUPLE INTEGRAL
          ["oint"      . "\u222E"]  ; ∮ CONTOUR INTEGRAL
          ["oiint"     . "\u222F"]  ; ∯ SURFACE INTEGRAL
          ["oiiint"    . "\u2230"]  ; ∰ VOLUME INTEGRAL
          ["FIXME"     . "\u2231"]  ; ∱ CLOCKWISE INTEGRAL
          ["FIXME"     . "\u2A11"]  ; ⨑ ANTICLOCKWISE INTEGRAL
          ["FIXME"     . "\u2232"]  ; ∲ CLOCKWISE CONTOUR INTEGRAL
          ["FIXME"     . "\u2233"]  ; ∳ ANTICLOCKWISE CONTOUR INTEGRAL

          ["alefsym"    . "\u2135"]  ; ℵ ALEF INFINITY SYMBOL
          ["weierp"     . "\u2118"]  ; ℘ WEIERSTRASS POWER SET (Script Capital P)
          ["image"      . "\u2111"]  ; ℑ IMAGINARY Part (Blackletter I)
          ["real"       . "\u211C"]  ; ℜ REAL NUMBER (Blackletter R)
          ["reals"      . "\u211D"]  ; ℝ DOUBLE-STRUCK REAL NUMBER (Doublestruck R)
          ["complex"    . "\u2102"]  ; ℂ COMPLEX NUMBERS (Doublestruck C)
          ["naturals"   . "\u2115"]  ; ℕ NATURAL NUMBERS (Doublestruck N)
          ["primes"     . "\u2119"]  ; ℙ PRIME NUMBERS (Doublestruck P)
          ["rationals"  . "\u211A"]  ; ℚ RATIONAL NUMBERS (Doublestruck Q)
          ["integers"   . "\u2124"]  ; ℤ INTEGERS (Doublestruck Z)

          ["forall"         . "\u2200"]  ; ∀ FOR ALL (Upside-down A)
          ["FIXME"          . "\u2201"]  ; ∁ COMPLEMENT (Thin C)
          ["exist"          . "\u2203"]  ; ∃ THERE EXISTS (Backwards E)
          ["exists"         . "\u2203"]
          ["notexist"       . "\u2204"]  ; ∄ THERE DOES NOT EXIST (Backwards E with slash)
          ["notexists"      . "\u2204"]
          ["nexists"        . "\u2204"]
          ["empty"          . "\u2205"]  ; ∅ EMPTY SET (O slash)
          ["emptyset"       . "\u2205"]  ; ∅ EMPTY SET (O slash)
          ["not"            . "\uAC"]    ; ¬ NOT SYMBOL (Corner)
          ["lnot"           . "\uAC"]    ; ¬ NOT SYMBOL (Corner)
          ;["tilde"         . "\u--"]    ; ˜ TILDE (Alternate Not Symbol)
          ["and"            . "\u2227"]  ; ∧ LOGICAL AND (Wedge or Upside down V Symbol)
          ["land"           . "\u2227"]
          ["wedge"          . "\u2227"]
          ["or"             . "\u2228"]  ; ∨ LOGICAL OR (V Symbol)
          ["lor"            . "\u2228"]
          ["vee"            . "\u2228"]
          ["xor"            . "\u22BB"]  ; ⊻ XOR
          ["nand"           . "\u22BC"]  ; ⊼ NAND
          ["nor"            . "\u22BD"]  ; ⊽ NOR
          ["cap"            . "\u2229"]  ; ∩ INTERSECTION (Cap or Upside Down U)
          ["inter"          . "\u2229"]
          ["cup"            . "\u222A"]  ; ∪ UNION (Cup or U Symbol)
          ["union"          . "\u222A"]
          ["isin"           . "\u2208"]  ; ∈ ELEMENT OF
          ["In"             . "\u2208"]
          ["notin"          . "\u2209"]  ; ∉ NOT AN ELEMENT OF
          ["in"             . "\u220A"]  ; ∊ SMALL ELEMENT OF
          ["isni"           . "\u220B"]  ; ∋ CONTAINS AS MEMBER
          ["Contains"       . "\u220B"]
          ["notcontains"    . "\u220C"]  ; ∌ DOES NOT CONTAIN AS MEMBER
          ["contains"       . "\u220D"]  ; ∍ SMALL CONTAINS AS MEMBER
          ["setminus"       . "\u2216"]  ; ∖ SET MINUS
          ["sub"            . "\u2282"]  ; ⊂ SUBSET OF (Sideways U with cap to left)
          ["subset"         . "\u2282"]
          ["sup"            . "\u2283"]  ; ⊃ SUPERSET OF (Sideways U with cap to right)
          ["superset"       . "\u2283"]
          ["nsub"           . "\u2284"]  ; ⊄ NOT A SUBSET OF (Subset with Slash)
          ["notsubset"      . "\u2284"]
          ["notsuperset"    . "\u2285"]  ; ⊅ NOT A SUPERSET OF (Superset with slash)
          ["sube"           . "\u2286"]  ; ⊆ SUBSET OF OR EQUAL TO (Subset with line below)
          ["subseteq"       . "\u2286"]
          ["supe"           . "\u2287"]  ; ⊇ SUPERSET OF OR EQUAL TO (Superset with line below)
          ["superseteq"     . "\u2287"]
          ["FIXME"          . "\u2288"]  ; ⊈ NEITHER A SUBSET OF NOR EQUAL TO
          ["FIXME"          . "\u2289"]  ; ⊉ NEITHER A SUPERSET OF NOR EQUAL TO
          ["FIXME"          . "\u228A"]  ; ⊊ SUBSET OF WITH NOT EQUAL TO
          ["FIXME"          . "\u228B"]  ; ⊋ SUPERSET OF WITH NOT EQUAL TO
          ["diamond"        . "\u22C4"]  ; ⋄ DIAMOND OPERATOR (Possibility)
          ;["FIXME"          . "\u2243"]  ; ≃ ASYMPTOTICALLY EQUAL TO (One to one Correspondence)
          ;["FIXME"          . "\u2244"]  ; ≄ NOT ASYMPTOTICALLY EQUAL TO
          ["FIXME"          . "\u228C"]  ; ⊌ MULTISET (U with arrow)
          ["FIXME"          . "\u228D"]  ; ⊍ MULTISET MULTIPLICATION (U with dot in center)
          ["FIXME"          . "\u228E"]  ; ⊎ MULTISET UNION (U with plus in center)
          ["FIXME"          . "\u22D0"]  ; ⋐ DOUBLE SUBSET
          ["FIXME"          . "\u22D1"]  ; ⋑ DOUBLE SUPERSET
          ["FIXME"          . "\u22D2"]  ; ⋒ DOUBLE INTERSECTION
          ["FIXME"          . "\u22D3"]  ; ⋓ DOUBLE UNION
          ["And"            . "\u22C0"]  ; ⋀ N-ARY LOGICAL AND
          ["bigwedge"       . "\u22C0"]
          ["Or"             . "\u22C1"]  ; ⋁ N-ARY LOGICAL OR
          ["bigvee"         . "\u22C1"]
          ["Inter"          . "\u22C2"]  ; ⋂ N-ARY INTERSECTION
          ["bigcap"         . "\u22C2"]
          ["Union"          . "\u22C3"]  ; ⋃ N-ARY UNION
          ["bigcup"         . "\u22C3"]
          ["curlyor"        . "\u22CE"]  ; ⋎ CURLY LOGICAL OR
          ["curlywedge"     . "\u22CE"]
          ["curlyand"       . "\u22CF"]  ; ⋏ CURLY LOGICAL AND
          ["curlyvee"       . "\u22CF"]
          ["oplus"          . "\u2295"]  ; ⊕ CIRCLED PLUS (Direct Sum)
          ["otimes"         . "\u2297"]  ; ⊗ CIRCLED TIMES (Vector Product)
          ["ominus"         . "\u2296"]  ; ⊖ CIRCLED MINUS
          ["oslash"         . "\u2298"]  ; ⊘ CIRCLED DIVISION SLASH
          ["dagger"         . "\u2020"]  ; † DAGGER
          ["ddagger"        . "\u2021"]  ; ‡ DOUBLE DAGGER


          ;; Greek letters
          ;; http://www.wizcity.com/Computers/Characters/GreekUTF8.php
          ["Alpha"     . "\u0391"]  ;  Α Greek capital letter alpha
          ["Beta"      . "\u0392"]  ;  Β Greek capital letter beta
          ["Gamma"     . "\u0393"]  ;  Γ Greek capital letter gamma
          ["Delta"     . "\u0394"]  ;  Δ Greek capital letter delta
          ["Epsilon"   . "\u0395"]  ;  Ε Greek capital letter epsilon
          ["Zeta"      . "\u0396"]  ;  Ζ Greek capital letter zeta
          ["Eta"       . "\u0397"]  ;  Η Greek capital letter eta
          ["Theta"     . "\u0398"]  ;  Θ Greek capital letter theta
          ["Iota"      . "\u0399"]  ;  Ι Greek capital letter iota
          ["Kappa"     . "\u039A"]  ;  Κ Greek capital letter kappa
          ["Lambda"    . "\u039B"]  ;  Λ Greek capital letter lambda
          ["Mu"        . "\u039C"]  ;  Μ Greek capital letter mu
          ["Nu"        . "\u039D"]  ;  Ν Greek capital letter nu
          ["Xi"        . "\u039E"]  ;  Ξ Greek capital letter xi
          ["Omicron"   . "\u039F"]  ;  Ο Greek capital letter omicron
          ["Pi"        . "\u03A0"]  ;  Π Greek capital letter pi
          ["Rho"       . "\u03A1"]  ;  Ρ Greek capital letter rho
          ["Sigma"     . "\u03A3"]  ;  Σ Greek capital letter sigma
          ["Tau"       . "\u03A4"]  ;  Τ Greek capital letter tau
          ["Upsilon"   . "\u03A5"]  ;  Υ Greek capital letter upsilon
          ["Phi"       . "\u03A6"]  ;  Φ Greek capital letter phi
          ["Chi"       . "\u03A7"]  ;  Χ Greek capital letter chi
          ["Psi"       . "\u03A8"]  ;  Ψ Greek capital letter psi
          ["Omega"     . "\u03A9"]  ;  Ω Greek capital letter omega
          ["alpha"     . "\u03B1"]  ;  α Greek small letter alpha
          ["beta"      . "\u03B2"]  ;  β Greek small letter beta
          ["gamma"     . "\u03B3"]  ;  γ Greek small letter gamma
          ["delta"     . "\u03B4"]  ;  δ Greek small letter delta
          ["epsilon"   . "\u03B5"]  ;  ε Greek small letter epsilon
          ["zeta"      . "\u03B6"]  ;  ζ Greek small letter zeta
          ["eta"       . "\u03B7"]  ;  η Greek small letter eta
          ["theta"     . "\u03B8"]  ;  θ Greek small letter theta
          ["iota"      . "\u03B9"]  ;  ι Greek small letter iota
          ["kappa"     . "\u03BA"]  ;  κ Greek small letter kappa
          ["lambda"    . "\u03BB"]  ;  λ Greek small letter lambda
          ["mu"        . "\u03BC"]  ;  μ Greek small letter mu
          ["nu"        . "\u03BD"]  ;  ν Greek small letter nu
          ["xi"        . "\u03BE"]  ;  ξ Greek small letter xi
          ["omicron"   . "\u03BF"]  ;  ο Greek small letter omicron
          ["pi"        . "\u03C0"]  ;  π Greek small letter pi
          ["rho"       . "\u03C1"]  ;  ρ Greek small letter rho
          ["sigmaf"    . "\u03C2"]  ;  ς Greek small letter final sigma
          ["sigma"     . "\u03C3"]  ;  σ Greek small letter sigma
          ["tau"       . "\u03C4"]  ;  τ Greek small letter tau
          ["upsilon"   . "\u03C5"]  ;  υ Greek small letter upsilon
          ["phi"       . "\u03C6"]  ;  φ Greek small letter phi
          ["chi"       . "\u03C7"]  ;  χ Greek small letter chi
          ["psi"       . "\u03C8"]  ;  ψ Greek small letter psi
          ["omega"     . "\u03C9"]  ;  ω Greek small letter omega
          ["thetasym"  . "\u03D1"]  ;  ϑ Greek small letter theta symbol
          ["upsih"     . "\u03D2"]  ;  ϒ Greek upsilon with hook symbol
          ["piv"       . "\u03D6"]  ;  ϖ Greek pi symbol
          ["varpi"     . "\u03D6"]

          ;; Arrows
          ;; http://www.unicode.org/charts/PDF/U2190.pdf
          ["larr"            . "\u2190"]  ;  ← leftwards arrow
          ["leftarrow"       . "\u2190"]
          ["uarr"            . "\u2191"]  ;  ↑ upwards arrow
          ["uparrow"         . "\u2191"]
          ["rarr"            . "\u2192"]  ;  → rightwards arrow
          ["rightarrow"      . "\u2192"]
          ["to"              . "\u2192"]
          ["darr"            . "\u2193"]  ;  ↓ downwards arrow
          ["downarrow"       . "\u2193"]
          ["harr"            . "\u2194"]  ;  ↔ left right arrow
          ["leftrightarrow"  . "\u2194"]
          ["crarr"           . "\u21B5"]  ;  ↵ downwards arrow with corner leftwards = carriage return
          ["lArr"            . "\u21D0"]  ;  ⇐ leftwards double arrow
          ["Leftarrow"       . "\u21D0"]
          ["uArr"            . "\u21D1"]  ;  ⇑ upwards double arrow
          ["Uparrow"         . "\u21D1"]
          ["rArr"            . "\u21D2"]  ;  ⇒ rightwards double arrow
          ["Rightarrow"      . "\u21D2"]
          ["dArr"            . "\u21D3"]  ;  ⇓ downwards double arrow
          ["Downarrow"       . "\u21D3"]
          ["hArr"            . "\u21D4"]  ;  ⇔ left right double arrow
          ["Leftrightarrow"  . "\u21D4"]

          ["updownarrow"     . "\u2195"]  ; ↕ UP DOWN ARROW
          ["northwestarrow"  . "\u2196"]  ; ↖ NORTH WEST ARROW
          ["northeastarrow"  . "\u2197"]  ; ↗ NORTH EAST ARROW
          ["southeastarrow"  . "\u2198"]  ; ↘ SOUTH EAST ARROW
          ["southwestarrow"  . "\u2199"]  ; ↙ SOUTH WEST ARROW
          ["FIXME"  . "\u219A"]  ; ↚ LEFTWARDS ARROW WITH STROKE
          ["FIXME"  . "\u219B"]  ; ↛ RIGHTWARDS ARROW WITH STROKE
          ["FIXME"  . "\u219C"]  ; ↜ LEFTWARDS WAVE ARROW
          ["FIXME"  . "\u219D"]  ; ↝ RIGHTWARDS WAVE ARROW
          ["FIXME"  . "\u219E"]  ; ↞ LEFTWARDS TWO HEADED ARROW
          ["FIXME"  . "\u219F"]  ; ↟ UPWARDS TWO HEADED ARROW
          ["FIXME"  . "\u21A0"]  ; ↠ RIGHTWARDS TWO HEADED ARROW
          ["FIXME"  . "\u21A1"]  ; ↡ DOWNWARDS TWO HEADED ARROW
          ["FIXME"  . "\u21A2"]  ; ↢ LEFTWARDS ARROW WITH TAIL
          ["FIXME"  . "\u21A3"]  ; ↣ RIGHTWARDS ARROW WITH TAIL
          ["FIXME"  . "\u21A4"]  ; ↤ LEFTWARDS ARROW FROM BAR
          ["FIXME"  . "\u21A5"]  ; ↥ UPWARDS ARROW FROM BAR
          ["FIXME"  . "\u21A6"]  ; ↦ RIGHTWARDS ARROW FROM BAR
          ["FIXME"  . "\u21A7"]  ; ↧ DOWNWARDS ARROW FROM BAR
          ["FIXME"  . "\u21A8"]  ; ↨ UP DOWN ARROW WITH BASE
          ["FIXME"  . "\u21A9"]  ; ↩ LEFTWARDS ARROW WITH HOOK
          ["FIXME"  . "\u21AA"]  ; ↪ RIGHTWARDS ARROW WITH HOOK
          ["FIXME"  . "\u21AB"]  ; ↫ LEFTWARDS ARROW WITH LOOP
          ["FIXME"  . "\u21AC"]  ; ↬ RIGHTWARDS ARROW WITH LOOP
          ["FIXME"  . "\u21AD"]  ; ↭ LEFT RIGHT WAVE ARROW
          ["FIXME"  . "\u21AE"]  ; ↮ LEFT RIGHT ARROW WITH STROKE
          ["FIXME"  . "\u21AF"]  ; ↯ DOWNWARDS ZIGZAG ARROW
          ["FIXME"  . "\u21B0"]  ; ↰ UPWARDS ARROW WITH TIP LEFTWARDS
          ["FIXME"  . "\u21B1"]  ; ↱ UPWARDS ARROW WITH TIP RIGHTWARDS
          ["FIXME"  . "\u21B2"]  ; ↲ DOWNWARDS ARROW WITH TIP LEFTWARDS
          ["FIXME"  . "\u21B3"]  ; ↳ DOWNWARDS ARROW WITH TIP RIGHTWARDS
          ["FIXME"  . "\u21B4"]  ; ↴ RIGHTWARDS ARROW WITH CORNER DOWNWARDS
          ["FIXME"  . "\u21B5"]  ; ↵ DOWNWARDS ARROW WITH CORNER LEFTWARDS
          ["FIXME"  . "\u21B6"]  ; ↶ ANTICLOCKWISE TOP SEMICIRCLE ARROW
          ["FIXME"  . "\u21B7"]  ; ↷ CLOCKWISE TOP SEMICIRCLE ARROW
          ["FIXME"  . "\u21B8"]  ; ↸ NORTH WEST ARROW TO LONG BAR
          ["FIXME"  . "\u21B9"]  ; ↹ LEFTWARDS ARROW TO BAR OVER RIGHTWARDS ARROW TO BAR
          ["FIXME"  . "\u21BA"]  ; ↺ ANTICLOCKWISE OPEN CIRCLE ARROW
          ["FIXME"  . "\u21BB"]  ; ↻ CLOCKWISE OPEN CIRCLE ARROW
          ["FIXME"  . "\u21BC"]  ; ↼ LEFTWARDS HARPOON WITH BARB UPWARDS
          ["FIXME"  . "\u21BD"]  ; ↽ LEFTWARDS HARPOON WITH BARB DOWNWARDS
          ["FIXME"  . "\u21BE"]  ; ↾ UPWARDS HARPOON WITH BARB RIGHTWARDS
          ["FIXME"  . "\u21BF"]  ; ↿ UPWARDS HARPOON WITH BARB LEFTWARDS
          ["FIXME"  . "\u21C0"]  ; ⇀ RIGHTWARDS HARPOON WITH BARB UPWARDS
          ["FIXME"  . "\u21C1"]  ; ⇁ RIGHTWARDS HARPOON WITH BARB DOWNWARDS
          ["FIXME"  . "\u21C2"]  ; ⇂ DOWNWARDS HARPOON WITH BARB RIGHTWARDS
          ["FIXME"  . "\u21C3"]  ; ⇃ DOWNWARDS HARPOON WITH BARB LEFTWARDS
          ["FIXME"  . "\u21C4"]  ; ⇄ RIGHTWARDS ARROW OVER LEFTWARDS ARROW
          ["FIXME"  . "\u21C5"]  ; ⇅ UPWARDS ARROW LEFTWARDS OF DOWNWARDS ARROW
          ["FIXME"  . "\u21C6"]  ; ⇆ LEFTWARDS ARROW OVER RIGHTWARDS ARROW
          ["FIXME"  . "\u21C7"]  ; ⇇ LEFTWARDS PAIRED ARROWS
          ["FIXME"  . "\u21C8"]  ; ⇈ UPWARDS PAIRED ARROWS
          ["FIXME"  . "\u21C9"]  ; ⇉ RIGHTWARDS PAIRED ARROWS
          ["FIXME"  . "\u21CA"]  ; ⇊ DOWNWARDS PAIRED ARROWS
          ["FIXME"  . "\u21CB"]  ; ⇋ LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
          ["FIXME"  . "\u21CC"]  ; ⇌ RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
          ["FIXME"  . "\u21CD"]  ; ⇍ LEFTWARDS DOUBLE ARROW WITH STROKE
          ["FIXME"  . "\u21CE"]  ; ⇎ LEFT RIGHT DOUBLE ARROW WITH STROKE
          ["FIXME"  . "\u21CF"]  ; ⇏ RIGHTWARDS DOUBLE ARROW WITH STROKE
          ["FIXME"  . "\u21D5"]  ; ⇕ UP DOWN DOUBLE ARROW
          ["FIXME"  . "\u21D6"]  ; ⇖ NORTH WEST DOUBLE ARROW
          ["FIXME"  . "\u21D7"]  ; ⇗ NORTH EAST DOUBLE ARROW
          ["FIXME"  . "\u21D8"]  ; ⇘ SOUTH EAST DOUBLE ARROW
          ["FIXME"  . "\u21D9"]  ; ⇙ SOUTH WEST DOUBLE ARROW
          ["FIXME"  . "\u21DA"]  ; ⇚ LEFTWARDS TRIPLE ARROW
          ["FIXME"  . "\u21DB"]  ; ⇛ RIGHTWARDS TRIPLE ARROW
          ["FIXME"  . "\u21DC"]  ; ⇜ LEFTWARDS SQUIGGLE ARROW
          ["FIXME"  . "\u21DD"]  ; ⇝ RIGHTWARDS SQUIGGLE ARROW
          ["FIXME"  . "\u21DE"]  ; ⇞ UPWARDS ARROW WITH DOUBLE STROKE
          ["FIXME"  . "\u21DF"]  ; ⇟ DOWNWARDS ARROW WITH DOUBLE STROKE
          ["FIXME"  . "\u21E0"]  ; ⇠ LEFTWARDS DASHED ARROW
          ["FIXME"  . "\u21E1"]  ; ⇡ UPWARDS DASHED ARROW
          ["FIXME"  . "\u21E2"]  ; ⇢ RIGHTWARDS DASHED ARROW
          ["FIXME"  . "\u21E3"]  ; ⇣ DOWNWARDS DASHED ARROW
          ["FIXME"  . "\u21E4"]  ; ⇤ LEFTWARDS ARROW TO BAR
          ["FIXME"  . "\u21E5"]  ; ⇥ RIGHTWARDS ARROW TO BAR
          ["FIXME"  . "\u21E6"]  ; ⇦ LEFTWARDS WHITE ARROW
          ["FIXME"  . "\u21E7"]  ; ⇧ UPWARDS WHITE ARROW
          ["FIXME"  . "\u21E8"]  ; ⇨ RIGHTWARDS WHITE ARROW
          ["FIXME"  . "\u21E9"]  ; ⇩ DOWNWARDS WHITE ARROW
          ["FIXME"  . "\u21EA"]  ; ⇪ UPWARDS WHITE ARROW FROM BAR
          ["FIXME"  . "\u21EB"]  ; ⇫ UPWARDS WHITE ARROW ON PEDESTAL
          ["FIXME"  . "\u21EC"]  ; ⇬ UPWARDS WHITE ARROW ON PEDESTAL WITH HORIZONTAL BAR
          ["FIXME"  . "\u21ED"]  ; ⇭ UPWARDS WHITE ARROW ON PEDESTAL WITH VERTICAL BAR
          ["FIXME"  . "\u21EE"]  ; ⇮ UPWARDS WHITE DOUBLE ARROW
          ["FIXME"  . "\u21EF"]  ; ⇯ UPWARDS WHITE DOUBLE ARROW ON PEDESTAL
          ["FIXME"  . "\u21F0"]  ; ⇰ RIGHTWARDS WHITE ARROW FROM WALL
          ["FIXME"  . "\u21F1"]  ; ⇱ NORTH WEST ARROW TO CORNER
          ["FIXME"  . "\u21F2"]  ; ⇲ SOUTH EAST ARROW TO CORNER
          ["FIXME"  . "\u21F3"]  ; ⇳ UP DOWN WHITE ARROW
          ["FIXME"  . "\u21F4"]  ; ⇴ RIGHT ARROW WITH SMALL CIRCLE
          ["FIXME"  . "\u21F5"]  ; ⇵ DOWNWARDS ARROW LEFTWARDS OF UPWARDS ARROW
          ["FIXME"  . "\u21F6"]  ; ⇶ THREE RIGHTWARDS ARROWS
          ["FIXME"  . "\u21F7"]  ; ⇷ LEFTWARDS ARROW WITH VERTICAL STROKE
          ["FIXME"  . "\u21F8"]  ; ⇸ RIGHTWARDS ARROW WITH VERTICAL STROKE
          ["FIXME"  . "\u21F9"]  ; ⇹ LEFT RIGHT ARROW WITH VERTICAL STROKE
          ["FIXME"  . "\u21FA"]  ; ⇺ LEFTWARDS ARROW WITH DOUBLE VERTICAL STROKE
          ["FIXME"  . "\u21FB"]  ; ⇻ RIGHTWARDS ARROW WITH DOUBLE VERTICAL STROKE
          ["FIXME"  . "\u21FC"]  ; ⇼ LEFT RIGHT ARROW WITH DOUBLE VERTICAL STROKE
          ["FIXME"  . "\u21FD"]  ; ⇽ LEFTWARDS OPEN-HEADED ARROW
          ["FIXME"  . "\u21FE"]  ; ⇾ RIGHTWARDS OPEN-HEADED ARROW
          ["FIXME"  . "\u21FF"]  ; ⇿ LEFT RIGHT OPEN-HEADED ARROW

          ;; http://www.wizcity.com/Computers/Characters/MathematicalUTF8.php
          ;["fnof"     . "\u0192"]  ;  ƒ Latin small f with hook = function = florin
          ["bull"      . "\u2022"]  ;  • bullet = black small circle
          ["hellip"    . "\u2026"]  ;  … horizontal ellipsis = three dot leader
          ;["prime"    . "\u2032"]  ;  ′ prime = minutes = feet
          ;["Prime"    . "\u2033"]  ;  ″ double prime = seconds = inches
          ["oline"     . "\u203E"]  ;  ‾ overline = spacing overscore
          ;["frasl"    . "\u2044"]  ;  ⁄ fraction slash
          ;["weierp"   . "\u2118"]  ;  ℘ script capital P = power set = Weierstrass p
          ;["image"    . "\u2111"]  ;  ℑ blackletter capital I = imaginary part
          ;["real"     . "\u211C"]  ;  ℜ blackletter capital R = real part symbol
          ["trade"     . "\u2122"]  ;  ™ trade mark sign
          ;["alefsym"  . "\u2135"]  ;  ℵ alef symbol = first transfinite cardinal
          ;["forall"   . "\u2200"]  ;  ∀ for all
          ;["part"     . "\u2202"]  ;  ∂ partial differential
          ;["exist"    . "\u2203"]  ;  ∃ there exists
          ;["empty"    . "\u2205"]  ;  ∅ empty set = null set = diameter
          ;["nabla"    . "\u2207"]  ;  ∇ nabla = backward difference
          ;["isin"     . "\u2208"]  ;  ∈ element of
          ;["notin"    . "\u2209"]  ;  ∉ not an element of
          ;["ni"       . "\u220B"]  ;  ∋ contains as member
          ["prod"      . "\u220F"]  ;  ∏ n-ary product = product sign
          ["product"   . "\u220F"]  ;  ∏ n-ary product = product sign
          ["sum"       . "\u2211"]  ;  ∑ n-ary sumation
          ;["minus"    . "\u2212"]  ;  − minus sign
          ["lowast"    . "\u2217"]  ;  ∗ asterisk operator
          ;["radic"    . "\u221A"]  ;  √ square root = radical sign
          ["prop"      . "\u221D"]  ;  ∝ proportional to
          ["propto"    . "\u221D"]  ;  ∝ proportional to
          ;["infin"    . "\u221E"]  ;  ∞ infinity
          ["ang"       . "\u2220"]  ;  ∠ angle
          ;["and"      . "\u2227"]  ;  ∧ logical and = wedge
          ;["or"       . "\u2228"]  ;  ∨ logical or = vee
          ;["cap"      . "\u2229"]  ;  ∩ intersection = cap
          ;["cup"      . "\u222A"]  ;  ∪ union = cup
          ;["int"      . "\u222B"]  ;  ∫ integral
          ;["there4"   . "\u2234"]  ;  ∴ therefore
          ["sim"       . "\u223C"]  ;  ∼ tilde operator = varies with = similar to
          ["cong"      . "\u2245"]  ;  ≅ approximately equal to
          ;["ne"       . "\u2260"]  ;  ≠ not equal to
          ["equiv"     . "\u2261"]  ;  ≡ identical to
          ;["le"       . "\u2264"]  ;  ≤ less-than or equal to
          ;["ge"       . "\u2265"]  ;  ≥ greater-than or equal to
          ;["sub"      . "\u2282"]  ;  ⊂ subset of
          ;["sup"      . "\u2283"]  ;  ⊃ superset of
          ;["nsub"     . "\u2284"]  ;  ⊄ not a subset of
          ;["sube"     . "\u2286"]  ;  ⊆ subset of or equal to
          ;["supe"     . "\u2287"]  ;  ⊇ superset of or equal to
          ;["oplus"    . "\u2295"]  ;  ⊕ circled plus = direct sum
          ;["otimes"   . "\u2297"]  ;  ⊗ circled times = vector product
          ["perp"      . "\u22A5"]  ;  ⊥ up tack = orthogonal to = perpendicular
          ;["sdot"     . "\u22C5"]  ;  ⋅ dot operator
          ;["lceil"    . "\u2308"]  ;  ⌈ left ceiling = apl upstile
          ;["rceil"    . "\u2309"]  ;  ⌉ right ceiling
          ;["lfloor"   . "\u230A"]  ;  ⌊ left floor = apl downstile
          ;["rfloor"   . "\u230B"]  ;  ⌋ right floor
          ;["lang"     . "\u2329"]  ;  〈 left-pointing angle bracket = bra
          ;["rang"     . "\u232A"]  ;  〉 right-pointing angle bracket = ket
          ["loz"       . "\u25CA"]  ;  ◊ lozenge
          ["lozenge"   . "\u25CA"]
          ["spades"    . "\u2660"]  ;  ♠ black spade suit
          ["clubs"     . "\u2663"]  ;  ♣ black club suit = shamrock
          ["hearts"    . "\u2665"]  ;  ♥ black heart suit = valentine
          ["heart"     . "\u2665"]
          ["diams"     . "\u2666"]  ;  ♦ black diamond suit

          ;; http://www.fileformat.info/info/unicode/category/Sm/list.htm
          ;; (name chosen by me)
          ;; See: https://en.wikipedia.org/wiki/Approximation#LaTeX_Symbols
          ["simeq"        . "\u2243"]  ; ≃ ASYMPTOTICALLY EQUAL TO
          ["simneq"       . "\u2244"]  ; ≄ NOT ASYMPTOTICALLY EQUAL TO
          ;["cong"        . "\u2245"]  ; ≅ APPROXIMATELY EQUAL TO (congruent)
          ["ncong"        . "\u2246"]  ; ≆ APPROXIMATELY BUT NOT ACTUALLY EQUAL TO (not congruent)
          ["notapproxeq"  . "\u2247"]  ; ≇ NEITHER APPROXIMATELY NOR ACTUALLY EQUAL TO
          ["almosteq"     . "\u2248"]  ; ≈ ALMOST EQUAL TO
          ["approx"       . "\u2248"]
          ["notalmosteq"  . "\u2249"]  ; ≉ NOT ALMOST EQUAL TO
          ["notapprox"    . "\u2249"]
          ["approxeq"     . "\u224A"]  ; ≊ ALMOST EQUAL OR EQUAL TO
          ["asymp"        . "\u224D"]  ; ≍ EQUIVALENT TO
          )))

(module unprefixed racket/base
  (require (for-syntax (submod ".." codes)
                       racket/base
                       racket/syntax)
           syntax/parse/define)

  (define-syntax (define-all stx)
    (syntax-parse stx
      [(_)
       (with-syntax ([((id str) ...)
                      (hash-map codes
                                (λ (a b) (list (format-id stx #:source stx
                                                          "~a" a)
                                               b )))])
         #`(begin
             (begin
               #;(writeln '(define id str))
               (provide id)
               (define id str))
             ...))]))

  (define-all))

(require (submod "." unprefixed))
(provide (prefix-out $ (all-from-out (submod "." unprefixed))))


