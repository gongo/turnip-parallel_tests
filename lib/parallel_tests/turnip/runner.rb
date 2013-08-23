require 'parallel_tests/rspec/runner'

module ParallelTests
  module Turnip
    class Runner < ParallelTests::RSpec::Runner
      NAME = 'Turnip'

      class << self
        def test_file_name
          'turnip'
        end

        def test_suffix_regexp
          '(\.feature|_spec\.rb)'
        end

        def find_tests(tests, options = {})
          (tests || []).map do |file_or_folder|
            if File.directory?(file_or_folder)
              files = files_in_folder(file_or_folder, options)
              files.grep(/#{test_suffix_regexp}$/).grep(options[:pattern]||//)
            else
              file_or_folder
            end
          end.flatten.uniq
        end
      end
    end
  end
end
