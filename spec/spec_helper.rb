require 'rspec'
require 'codeclimate-test-reporter'

spec_path = File.dirname(__FILE__)
$LOAD_PATH << File.expand_path('../lib', spec_path)

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

require 'capybara/rspec'
require 'prismatic'
