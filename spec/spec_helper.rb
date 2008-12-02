$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/../lib/netflix")

require 'netflix'

require 'rubygems'
require "spec"

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
