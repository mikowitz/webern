\version "2.16.2"
\include "english.ly"

#(set-global-staff-size 13)

rows = {
\time 12/4
\override Staff.Stem #'transparent = ##t
\mark "p0" c'' b' ef'' e'' af' g' a' f' fs' cs'' d'' bf'
\mark "p1" cs'' c'' e'' f' a' af' bf' fs' g' d'' ef'' b'
\mark "p2" d'' cs'' f' fs' bf' a' b' g' af' ef'' e'' c''
\mark "p3" ef'' d'' fs' g' b' bf' c'' af' a' e'' f' cs''
\mark "p4" e'' ef'' g' af' c'' b' cs'' a' bf' f' fs' d''
\mark "p5" f' e'' af' a' cs'' c'' d'' bf' b' fs' g' ef''
\mark "p6" fs' f' a' bf' d'' cs'' ef'' b' c'' g' af' e''
\mark "p7" g' fs' bf' b' ef'' d'' e'' c'' cs'' af' a' f'
\mark "p8" af' g' b' c'' e'' ef'' f' cs'' d'' a' bf' fs'
\mark "p9" a' af' c'' cs'' f' e'' fs' d'' ef'' bf' b' g'
\mark "p10" bf' a' cs'' d'' fs' f' g' ef'' e'' b' c'' af'
\mark "p11" b' bf' d'' ef'' g' fs' af' e'' f' c'' cs'' a'
\bar "||"
\mark "i0" c'' cs'' a' af' e'' f' ef'' g' fs' b' bf' d''
\mark "i1" cs'' d'' bf' a' f' fs' e'' af' g' c'' b' ef''
\mark "i2" d'' ef'' b' bf' fs' g' f' a' af' cs'' c'' e''
\mark "i3" ef'' e'' c'' b' g' af' fs' bf' a' d'' cs'' f'
\mark "i4" e'' f' cs'' c'' af' a' g' b' bf' ef'' d'' fs'
\mark "i5" f' fs' d'' cs'' a' bf' af' c'' b' e'' ef'' g'
\mark "i6" fs' g' ef'' d'' bf' b' a' cs'' c'' f' e'' af'
\mark "i7" g' af' e'' ef'' b' c'' bf' d'' cs'' fs' f' a'
\mark "i8" af' a' f' e'' c'' cs'' b' ef'' d'' g' fs' bf'
\mark "i9" a' bf' fs' f' cs'' d'' c'' e'' ef'' af' g' b'
\mark "i10" bf' b' g' fs' d'' ef'' cs'' f' e'' a' af' c''
\mark "i11" b' c'' af' g' ef'' e'' d'' fs' f' bf' a' cs''
\bar "||"
\mark "r0" c'' e'' ef'' af' g' b' a' bf' fs' f' cs'' d''
\mark "r1" cs'' f' e'' a' af' c'' bf' b' g' fs' d'' ef''
\mark "r2" d'' fs' f' bf' a' cs'' b' c'' af' g' ef'' e''
\mark "r3" ef'' g' fs' b' bf' d'' c'' cs'' a' af' e'' f'
\mark "r4" e'' af' g' c'' b' ef'' cs'' d'' bf' a' f' fs'
\mark "r5" f' a' af' cs'' c'' e'' d'' ef'' b' bf' fs' g'
\mark "r6" fs' bf' a' d'' cs'' f' ef'' e'' c'' b' g' af'
\mark "r7" g' b' bf' ef'' d'' fs' e'' f' cs'' c'' af' a'
\mark "r8" af' c'' b' e'' ef'' g' f' fs' d'' cs'' a' bf'
\mark "r9" a' cs'' c'' f' e'' af' fs' g' ef'' d'' bf' b'
\mark "r10" bf' d'' cs'' fs' f' a' g' af' e'' ef'' b' c''
\mark "r11" b' ef'' d'' g' fs' bf' af' a' f' e'' c'' cs''
\bar "||"
\mark "ri0" c'' af' a' e'' f' cs'' ef'' d'' fs' g' b' bf'
\mark "ri1" cs'' a' bf' f' fs' d'' e'' ef'' g' af' c'' b'
\mark "ri2" d'' bf' b' fs' g' ef'' f' e'' af' a' cs'' c''
\mark "ri3" ef'' b' c'' g' af' e'' fs' f' a' bf' d'' cs''
\mark "ri4" e'' c'' cs'' af' a' f' g' fs' bf' b' ef'' d''
\mark "ri5" f' cs'' d'' a' bf' fs' af' g' b' c'' e'' ef''
\mark "ri6" fs' d'' ef'' bf' b' g' a' af' c'' cs'' f' e''
\mark "ri7" g' ef'' e'' b' c'' af' bf' a' cs'' d'' fs' f'
\mark "ri8" af' e'' f' c'' cs'' a' b' bf' d'' ef'' g' fs'
\mark "ri9" a' f' fs' cs'' d'' bf' c'' b' ef'' e'' af' g'
\mark "ri10" bf' fs' g' d'' ef'' b' cs'' c'' e'' f' a' af'
\mark "ri11" b' g' af' ef'' e'' c'' d'' cs'' f' fs' bf' a'
\bar "||"
}
\score {
  <<
    \new Staff \rows
  >>
}
