\version "2.17.0"
\language "english"

\new Score {
  \new Staff {
    {
      \override Staff.TimeSignature #'stencil = ##f
      \override Staff.Stem #'transparent = ##t
      \accidentalStyle Score.dodecaphonic
      \time 12/4
            c' d' cs' ef' e' fs' f' g' af' bf' a' b'
      \bar "|."
    }
  }
}
