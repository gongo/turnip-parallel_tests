require 'parallel_tests/rspec/runner'
require 'parallel_tests/grouper'

module ParallelTests
  module Turnip
    class Runner < ParallelTests::RSpec::Runner
      NAME = 'Turnip'

      class << self
        def test_file_name
          'turnip'
        end

        #
        # @note
        #   Conditions of the grouping:
        #     feature: number of turnip steps.
        #        spec: filesize.
        #
        # @param   [Array]    tests       Selected files and folders at commandline.
        # @param   [Integer]  num_groups  Number of processes to use.
        # @param   [Hash]     options
        #
        # @return  [Array]    Test filenames that are grouped.
        #
        def tests_in_groups(tests, num_groups, options={})
          features, specs = find_features_and_specs(tests, options)

          ftests = ::ParallelTests::Grouper.by_steps(features, num_groups, options)
          stests = ::ParallelTests::Grouper.in_even_groups_by_size(with_runtime_info(specs), num_groups, options)
          ftests.zip(stests).map { |t| t.flatten }
        end

        #
        # @param   [Array]  tests     see +tests_in_groups+
        # @param   [Hash]   options   see +tests_in_groups+
        #
        # @return  [Array]  two array of feature and spec filename
        #
        def find_features_and_specs(tests, options = {})
          files = (tests || []).map do |file_or_folder|
            if File.directory?(file_or_folder)
              files = files_in_folder(file_or_folder, options)
              files.grep(/(\.feature|_spec\.rb)$/).grep(options[:pattern]||//)
            else
              file_or_folder
            end
          end.flatten.uniq

          files.partition { |file| file =~ /\.feature$/ }
        end
      end
    end
  end
end
