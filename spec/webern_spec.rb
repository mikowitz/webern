require 'spec_helper'

describe Webern do
  it 'should output correctly' do
    row = Webern::Row.new(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9)
    puts
    Webern::Formatters::Text.new(row).draw
    Webern::Formatters::Text.new(row, false).write_to_file('/Users/mikowitz/Desktop/row.txt')
  end
end
