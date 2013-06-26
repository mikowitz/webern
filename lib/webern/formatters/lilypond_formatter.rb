module Webern
  module Formatters
    class LilypondFormatter < BaseFormatter
      def write_to_file
        File.open("#{@filepath}.ly", 'w') do |f|
          f << LILYPOND_HEADER
          f << "rows = {\n"
          f << "\\time 12/4\n"
          f << "\\override Staff.Stem #'transparent = ##t\n"
          {p: :prime, i: :inversion, r: :retrograde, ri: :retrograde_inversion}.each do |key, transformation|
            (0..11).each do |transposition|
              f << "\\mark \"#{key}#{transposition}\" "
              f << @prime_row.send(transformation).zero.transpose(transposition).map{|n| lilypond_pitch(n) }.join(' ') + "\n"
            end
            f << "\\bar \"||\"\n"
          end
          f << "}\n"
          f << LILYPOND_SCORE_BLOCK
        end
      end

      def lilypond_pitch(n)
        %w{ c'' cs'' d'' ef'' e'' f' fs' g' af' a' bf' b' }[n]
      end
    end
  end
end

LILYPOND_HEADER = <<-pond
\\version "2.16.2"
\\include "english.ly"

#(set-global-staff-size 13)

pond

LILYPOND_SCORE_BLOCK = <<-pond
\\score {
  <<
    \\new Staff \\rows
  >>
}
pond
