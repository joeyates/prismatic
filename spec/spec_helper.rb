require 'rspec'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

spec_path = File.dirname(__FILE__)
$LOAD_PATH << File.expand_path('../lib', spec_path)

require 'prismatic'
