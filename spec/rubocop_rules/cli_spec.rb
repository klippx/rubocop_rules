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

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:run_process)
        .with(command: 'rubocop -a')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:run_process)
        .with(command: 'rubocop --auto-gen-config')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:insert_into_file)
        .with('.rubocop.yml', '  - .rubocop_todo.yml', after: '  - .rubocop_common.yml\n')

      RubocopRules::CLI::Commands.start(['init'])
    end
  end

  describe '$ rubocop-rules update', :silent do
    it 'copies rubocop_common' do
      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:remove_file)
        .with('.rubocop_common.yml')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:copy_file)
        .with('.rubocop_common.yml', '.rubocop_common.yml')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:remove_file)
        .with('.rubocop_todo.yml')

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:run_process)
        .with(command: 'rubocop -a', silent: true)

      expect_any_instance_of(RubocopRules::CLI::Commands)
        .to receive(:run_process)
        .with(command: 'rubocop --auto-gen-config', silent: true)

      RubocopRules::CLI::Commands.start(['update'])
    end
  end
end
