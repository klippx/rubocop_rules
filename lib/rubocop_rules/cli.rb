require 'thor'

module RubocopRules
  module CLI
    # CLI for initializing a project with RubocopRules, and keeping it up to date
    class Commands < Thor
      include Thor::Actions

      map '-v' => :version
      map '--version' => :version

      desc 'version', 'Outputs the version number'
      def version
        puts RubocopRules::VERSION
      end

      desc 'init', 'Initialize your project with RubocopRules'
      def init
        copy_file '.rubocop_common.yml', '.rubocop_common.yml'
        copy_file '.rubocop.yml', '.rubocop.yml'
        copy_file 'spec/lint_spec.rb', 'spec/lint_spec.rb'
      end

      desc 'update', 'Update your project with latest RubocopRules'
      def update
        copy_file '.rubocop_common.yml', '.rubocop_common.yml'
      end

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../..'))
      end
    end
  end
end
