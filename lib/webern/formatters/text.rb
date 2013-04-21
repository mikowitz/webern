module Webern
  module Formatters
    class Text < Base
      def draw
        output($stdout)
      end


      def write_to_file(filename)
        File.open(filename, 'w') do |f|
          output(f)
        end
      end

      private 

      def output(target)
        @prime_row.inversion.each do |i|
          target << border_row
          target << empty_row
          target << @prime_row.transpose(i).map{|n| pitch_cell(n) }.join + "|\n"
          target << empty_row
        end
        target << border_row
      end

      def border_row; ('|---------' * 12) + "|\n"; end
      def empty_row; ('|         ' * 12) + "|\n"; end
      def pitch_cell(n)
        '|   %s    ' % (pitch_value(n)).rjust(2)
      end
    end
  end
end
