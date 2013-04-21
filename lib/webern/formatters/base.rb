module Webern
  module Formatters
    class Base
      PITCH_CLASSES = %w{ C C# D Eb E F F# G Ab A Bb B }
      def initialize(prime_row, show_pitch_classes=true)
        @prime_row = prime_row
        @show_pitch_classes = show_pitch_classes
      end
    end
  end
end
