module Webern
  module Formatters
    def self.formatter(format)
      case format.to_sym
      when :pdf then PdfFormatter
      when :text then TextFormatter
      when :lilypond then LilypondFormatter
      else raise "cannot find formatter for format #{format}"
      end
    end
  end
end
