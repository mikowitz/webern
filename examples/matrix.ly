\version "2.17.0"
\language "english"

\new Score {
  \new Staff {
    {
      \override Staff.TimeSignature #'stencil = ##f
      \override Staff.Stem #'transparent = ##t
      \accidentalStyle Score.dodecaphonic
      \time 12/4
            c'\mark "p0" d' cs' ef' e' fs' f' g' af' bf' a' b'
      bf'\mark "p10" c' b' cs' d' e' ef' f' fs' af' g' a'
      b'\mark "p11" cs' c' d' ef' f' e' fs' g' a' af' bf'
      a'\mark "p9" b' bf' c' cs' ef' d' e' f' g' fs' af'
      af'\mark "p8" bf' a' b' c' d' cs' ef' e' fs' f' g'
      fs'\mark "p6" af' g' a' bf' c' b' cs' d' e' ef' f'
      g'\mark "p7" a' af' bf' b' cs' c' d' ef' f' e' fs'
      f'\mark "p5" g' fs' af' a' b' bf' c' cs' ef' d' e'
      e'\mark "p4" fs' f' g' af' bf' a' b' c' d' cs' ef'
      d'\mark "p2" e' ef' f' fs' af' g' a' bf' c' b' cs'
      ef'\mark "p3" f' e' fs' g' a' af' bf' b' cs' c' d'
      cs'\mark "p1" ef' d' e' f' g' fs' af' a' b' bf' c'
      \bar "||"
      b'\mark "r0" a' bf' af' g' f' fs' e' ef' cs' d' c'
      a'\mark "r10" g' af' fs' f' ef' e' d' cs' b' c' bf'
      bf'\mark "r11" af' a' g' fs' e' f' ef' d' c' cs' b'
      af'\mark "r9" fs' g' f' e' d' ef' cs' c' bf' b' a'
      g'\mark "r8" f' fs' e' ef' cs' d' c' b' a' bf' af'
      f'\mark "r6" ef' e' d' cs' b' c' bf' a' g' af' fs'
      fs'\mark "r7" e' f' ef' d' c' cs' b' bf' af' a' g'
      e'\mark "r5" d' ef' cs' c' bf' b' a' af' fs' g' f'
      ef'\mark "r4" cs' d' c' b' a' bf' af' g' f' fs' e'
      cs'\mark "r2" b' c' bf' a' g' af' fs' f' ef' e' d'
      d'\mark "r3" c' cs' b' bf' af' a' g' fs' e' f' ef'
      c'\mark "r1" bf' b' a' af' fs' g' f' e' d' ef' cs'
      \bar "||"
      c'\mark "i0" bf' b' a' af' fs' g' f' e' d' ef' cs'
      bf'\mark "i10" af' a' g' fs' e' f' ef' d' c' cs' b'
      b'\mark "i11" a' bf' af' g' f' fs' e' ef' cs' d' c'
      a'\mark "i9" g' af' fs' f' ef' e' d' cs' b' c' bf'
      af'\mark "i8" fs' g' f' e' d' ef' cs' c' bf' b' a'
      fs'\mark "i6" e' f' ef' d' c' cs' b' bf' af' a' g'
      g'\mark "i7" f' fs' e' ef' cs' d' c' b' a' bf' af'
      f'\mark "i5" ef' e' d' cs' b' c' bf' a' g' af' fs'
      e'\mark "i4" d' ef' cs' c' bf' b' a' af' fs' g' f'
      d'\mark "i2" c' cs' b' bf' af' a' g' fs' e' f' ef'
      ef'\mark "i3" cs' d' c' b' a' bf' af' g' f' fs' e'
      cs'\mark "i1" b' c' bf' a' g' af' fs' f' ef' e' d'
      \bar "||"
      cs'\mark "ri0" ef' d' e' f' g' fs' af' a' b' bf' c'
      b'\mark "ri10" cs' c' d' ef' f' e' fs' g' a' af' bf'
      c'\mark "ri11" d' cs' ef' e' fs' f' g' af' bf' a' b'
      bf'\mark "ri9" c' b' cs' d' e' ef' f' fs' af' g' a'
      a'\mark "ri8" b' bf' c' cs' ef' d' e' f' g' fs' af'
      g'\mark "ri6" a' af' bf' b' cs' c' d' ef' f' e' fs'
      af'\mark "ri7" bf' a' b' c' d' cs' ef' e' fs' f' g'
      fs'\mark "ri5" af' g' a' bf' c' b' cs' d' e' ef' f'
      f'\mark "ri4" g' fs' af' a' b' bf' c' cs' ef' d' e'
      ef'\mark "ri2" f' e' fs' g' a' af' bf' b' cs' c' d'
      e'\mark "ri3" fs' f' g' af' bf' a' b' c' d' cs' ef'
      d'\mark "ri1" e' ef' f' fs' af' g' a' bf' c' b' cs'
      \bar "||"
      b'\mark "ir0" cs' c' d' ef' f' e' fs' g' a' af' bf'
      a'\mark "ir10" b' bf' c' cs' ef' d' e' f' g' fs' af'
      bf'\mark "ir11" c' b' cs' d' e' ef' f' fs' af' g' a'
      af'\mark "ir9" bf' a' b' c' d' cs' ef' e' fs' f' g'
      g'\mark "ir8" a' af' bf' b' cs' c' d' ef' f' e' fs'
      f'\mark "ir6" g' fs' af' a' b' bf' c' cs' ef' d' e'
      fs'\mark "ir7" af' g' a' bf' c' b' cs' d' e' ef' f'
      e'\mark "ir5" fs' f' g' af' bf' a' b' c' d' cs' ef'
      ef'\mark "ir4" f' e' fs' g' a' af' bf' b' cs' c' d'
      cs'\mark "ir2" ef' d' e' f' g' fs' af' a' b' bf' c'
      d'\mark "ir3" e' ef' f' fs' af' g' a' bf' c' b' cs'
      c'\mark "ir1" d' cs' ef' e' fs' f' g' af' bf' a' b'
      \bar "|."
    }
  }
}
