require 'thor'
require 'open3'
require 'git'
require 'yaml'

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

      desc 'init', 'Initialize RubocopRules in your project'
      def init
        puts 'Copying config... '
        copy_file 'templates/.rubosync.yml', '.rubosync.yml'
        copy_file 'templates/.rubocop.yml', '.rubocop.yml'
        copy_file 'spec/lint_spec.rb', 'spec/lint_spec.rb'

        ensure_rubosync_config
        rubosync_common

        print 'Generating rubocop_todo...'
        generate_todo

        puts 'Adding rubocop_todo to configuration... '
        insert_into_file '.rubocop.yml', '  - .rubocop_todo.yml', after: "  - .rubocop_common.yml\n"
      end

      desc 'update', 'Regenerate RubocopRules configuration in your project'
      def update
        puts 'Recreating configuration...'
        ensure_rubosync_config
        remove_file '.rubocop_common.yml'
        rubosync_common

        puts 'Regenerating rubocop_todo...'
        remove_file '.rubocop_todo.yml'
        comment_lines '.rubocop.yml', /\.rubocop_todo\.yml/
        generate_todo(silent: true)
        uncomment_lines '.rubocop.yml', /\.rubocop_todo\.yml/
      end

      private

      def generate_todo(silent: false)
        run_process(command: 'rubocop -a', silent: silent)
        run_process(command: 'rubocop --auto-gen-config', silent: silent)
      end

      def ensure_rubosync_config
        unless File.exist?('.rubosync.yml')
          raise 'Missing configuration file! Please add and configure .rubosync.yml'
        end
        @config = YAML.safe_load(ERB.new(File.read('.rubosync.yml')).result, [], [], true)
      end

      def rubosync_common
        unless @config && @config['git'] && @config['git']['repo']
          raise 'Missing git repo in configuration! Please configure .rubosync.yml'
        end
        repo = @config['git']['repo']

        puts "Downloading latest configuration from #{repo}..."
        Git.clone(repo, 'common')
        copy_file Dir.pwd + '/common/.rubocop_common.yml', '.rubocop_common.yml'
      ensure
        FileUtils.rm_rf('./common')
      end

      def run_process(command:, silent: false)
        output = ''
        Open3.popen2(command) do |stdin, stdout_stderr, wait_thr|
          stdin.close
          output = stdout_stderr.read
          wait_thr.value
        end
        puts output.split("\n").last unless silent
      end
    end
  end
end
