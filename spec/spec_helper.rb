require 'rubygems'
require 'spork'
# uncomment the following line to use spork with the debugger
# require 'spork/ext/ruby-debug'

Spork.prefork do
  require File.dirname(__FILE__) + "/../config/environment"
  require 'rspec/rails'

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
