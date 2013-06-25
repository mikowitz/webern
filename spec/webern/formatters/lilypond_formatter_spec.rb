require 'spec_helper'

describe Webern::Formatters::LilypondFormatter do
  it 'should write to file correctly' do
    row = Webern::Row.new(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9)
    row.write(:lilypond, path: 'spec/test_files')
    expect('row.ly').to be_generated_correctly
  end
end
