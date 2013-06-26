require 'spec_helper'

describe Webern::Formatters::PdfFormatter do
  it 'should write to file correctly' do
    row = Webern::Row.new(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9)
    row.write(:pdf, path: 'spec/test_files')
    expect('row.pdf').to be_generated_correctly
  end
end
