require 'prawn'

module Webern
  module Formatters
    class Pdf < Base
      def write_to_file(filename)
        data = @prime_row.inversion.map do |i| 
          @prime_row.transpose(i).map do |n| 
            pitch_value(n)
          end
        end
        Prawn::Document.generate(filename) do |pdf|
          pdf.table data, cell_style: { width: 42, height: 42, align: :center, padding: 10}
        end
      end
    end
  end
end
