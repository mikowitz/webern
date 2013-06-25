require 'spec_helper'

describe Webern::Formatters::TextFormatter do
  before do
    @row = Webern::Row.new(11, 10, 2, 3, 7, 6, 8, 4, 5, 0, 1, 9)
  end

  it 'should write to file correctly' do
    @row.write(:text, show_pitches: false, path: 'spec/test_files')
    expect('row.txt').to be_generated_correctly
  end

  it 'should print to the console correctly' do
    output = capture_stdout { @row.draw(show_pitches: false) }
    expect(output).to eq File.read('spec/fixtures/files/row.txt')
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end
