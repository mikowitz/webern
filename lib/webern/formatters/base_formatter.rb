module Webern
  module Formatters
    class BaseFormatter
      DEFAULT_OPTS = { show_pitches: true, path: '.' }
      PITCH_CLASSES = %w{ C C# D Eb E F F# G Ab A Bb B }
      def initialize(row, opts={})
        opts = DEFAULT_OPTS.merge(opts)
        @prime_row = row
        @show_pitches = opts[:show_pitches]
        @path = opts[:path].sub(/\/$/, '')
        @filename = opts[:filename] || 'row'
        @filepath = "#{@path}/#{@filename}"
      end

      def pitch_value(n)
        @show_pitches ? PITCH_CLASSES[n] : n.to_s
      end
    end
  end
end
