require 'rubygems'
require 'bundler/setup'
require 'webern'
require 'fileutils'
include FileUtils

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:all) { mkdir 'spec/test_files' }
  config.after(:all) { rm_r 'spec/test_files' }
end
