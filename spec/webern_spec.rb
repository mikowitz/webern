require 'spec_helper'

describe Webern do
  it 'should output correctly' do
    row = Webern::Row.new(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9)
    Webern::Formatters::Text.new(row, false).write_to_file('row.txt')
    Webern::Formatters::Pdf.new(row).write_to_file('row.pdf')
    Webern::Formatters::Lilypond.new(row).write_to_file('lilypond-row.ly')
  end
end
