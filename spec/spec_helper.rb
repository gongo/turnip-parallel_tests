require 'coveralls'
Coveralls.wear!

module Turnip::ParallelTests
  module Spec
    extend self

    def test_file_directory
      File.dirname(__FILE__) + '/data'
    end

    def format_filename(filenames)
      filenames.map do |filename|
        filename.sub(test_file_directory + '/', '')
      end
    end
  end
end
