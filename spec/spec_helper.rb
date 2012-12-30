$:.unshift File.expand_path('../../lib', __FILE__)

require 'warehouse'

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end
