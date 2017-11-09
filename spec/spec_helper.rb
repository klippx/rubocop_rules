require 'bundler/setup'
require 'rubocop_rules'

Dir.entries('./spec/support').select { |f| f =~ /\.rb$/ }.each do |f|
  load "./spec/support/#{f}"
end

RSpec.configure do |config|
  include CLIHelper
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.around(:each, :silent) do |example|
    capture_stdout { example.run }
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
