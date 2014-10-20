require 'rspec'
require 'codeclimate-test-reporter'

spec_path = File.dirname(__FILE__)
$LOAD_PATH << File.expand_path('../lib', spec_path)

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/vendor/'
  end
end

require 'prismatic'
