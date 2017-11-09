require 'spec_helper'
require 'rubocop_rules/cli'

RSpec.describe RubocopRules::CLI do
  describe '$ rubocop-rules' do
    it 'prints help text' do
      output = capture_stdout { RubocopRules::CLI::Commands.start([]) }
      expect(output).to include 'help [COMMAND]  # Describe available commands'
    end
  end

  describe '$ rubocop-rules init' do
    it 'copies rubocop_common', :silent do
      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:copy_file)
        .with('.rubocop_common.yml', '.rubocop_common.yml')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:copy_file)
        .with('.rubocop.yml', '.rubocop.yml')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:copy_file)
        .with('spec/lint_spec.rb', 'spec/lint_spec.rb')

      RubocopRules::CLI::Commands.start(['init'])
    end
  end

  describe '$ rubocop-rules update', :silent do
    it 'copies rubocop_common' do
      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:copy_file)
        .with('.rubocop_common.yml', '.rubocop_common.yml')

      RubocopRules::CLI::Commands.start(['update'])
    end
  end
end
