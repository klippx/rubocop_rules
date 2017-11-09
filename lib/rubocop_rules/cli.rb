require 'thor'
require 'open3'

module RubocopRules
  module CLI
    # CLI for initializing a project with RubocopRules, and keeping it up to date
    class Commands < Thor
      include Thor::Actions

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../..'))
      end

      map '-v' => :version
      map '--version' => :version

      desc 'version', 'Outputs the version number'
      def version
        puts RubocopRules::VERSION
      end

      desc 'init', 'Initialize your project with RubocopRules'
      def init
        puts 'Creating configuration...'
        copy_file '.rubocop_common.yml', '.rubocop_common.yml'
        copy_file '.rubocop.yml', '.rubocop.yml'
        copy_file 'spec/lint_spec.rb', 'spec/lint_spec.rb'

        print 'Autocorrecting your code... '
        result = run_process('rubocop -a')
        puts result.split("\n").last

        print 'Generating rubocop_todo... '
        result = run_process('rubocop --auto-gen-config')
        puts result.split("\n").last
      end

      desc 'update', 'Update your project with latest RubocopRules'
      def update
        copy_file '.rubocop_common.yml', '.rubocop_common.yml'
      end

      private

      def run_process(command)
        output = ''
        Open3.popen2(command) do |stdin, stdout_stderr, wait_thr|
          stdin.close
          output = stdout_stderr.read
          wait_thr.value
        end
        output
      end
    end
  end
end
