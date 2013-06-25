module Webern
  class Row < Array
    def initialize(*row)
      @row = row 
      replace complete_row
    end

    def zero!
      replace zero
    end

    def prime
      Row.new *self
    end

    def inversion
      Row.new *self.map{|i| (12 - i) % 12}
    end

    def retrograde
      Row.new *self.reverse
    end

    def retrograde_inversion
      Row.new *self.retrograde.inversion
    end

    def transpose(distance)
      Row.new *self.map{|i| (i + distance) % 12 }
    end

    def zero
      Row.new *self.map{|i| (i + 12 - self[0]) % 12}
    end

    def write(format, opts={})
      Webern::Formatters.formatter(format).new(self, opts).write_to_file
    end

    def draw(opts={})
      Webern::Formatters::TextFormatter.new(self, opts).draw
    end

    private

    def complete_row
      missing = Array(0..11) - @row
      @row + missing
    end
  end
end
