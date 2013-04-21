module Webern
  module Formatters
    class Text < Base
      def draw(show_pitch_classes=true)
        @prime_row.inversion.each do |i|
          puts border_row
          puts empty_row
          puts @prime_row.transpose(i).map{|n| pitch_cell(n) }.join + '|' + "\n"
          puts empty_row
        end
        puts border_row
      end

      def write_to_file(filename, show_pitch_classes=true)
        File.open(filename, 'w') do |f|
          @prime_row.inversion.each do |i|
            f << border_row + "\n"
            f << empty_row + "\n"
            f << @prime_row.transpose(i).map{|n| pitch_cell(n) }.join + '|' + "\n"
            f << empty_row + "\n"
          end
          f << border_row + "\n"
        end
      end

      def border_row; ('|---------' * 12) + '|'; end
      def empty_row; ('|         ' * 12) + '|'; end
      def pitch_cell(n)
        '|   %s    ' % (@show_pitch_classes ? PITCH_CLASSES[n] : n.to_s).rjust(2)
      end
    end
  end
end
