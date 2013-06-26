RSpec::Matchers.define :be_generated_correctly do
  match do |filename|
    @fixture_filename = "spec/fixtures/files/#{filename}"
    @generated_filename = "spec/test_files/#{filename}"
    compare_file(@generated_filename, @fixture_filename)
  end

  failure_message_for_should do
    "#{system("diff #{@fixture_filename} #{@generated_filename}")}"
  end

  failure_message_for_should_not do
    "#{@generated_filename} should not have matched #{@fixture_filename}"
  end
end
