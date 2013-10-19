require 'spec_helper.rb'
require 'parallel_tests/turnip/runner'

describe ParallelTests::Turnip::Runner do
  let(:runner) do
    ParallelTests::Turnip::Runner
  end

  let(:helper) do
    Turnip::ParallelTests::Spec
  end

  let(:options) do
    {}
  end

  let(:find_features_and_specs) do
    features, specs = runner.find_features_and_specs(tests, options)
    [helper.format_filename(features), helper.format_filename(specs)]
  end

  let(:tests_in_groups) do
    runner.tests_in_groups(tests, cpus, options).map do |group|
      helper.format_filename(group)
    end
  end

  context 'selected directories' do
    let(:tests) do
      [helper.test_file_directory, helper.test_file_directory + '/features']
    end

    describe '.find_features_and_specs' do
      it 'get all feature and spec files' do
        actual_features, actual_specs = find_features_and_specs

        expect_features = [
          'features/battle.feature', 'features/battle2.feature',
          'features/battle3.feature', 'features/songs.feature'
        ]
        expect_specs = ['big_size_spec.rb', 'features/small_size_spec.rb']

        actual_features.should =~ expect_features
        actual_specs.should =~ expect_specs
      end
    end

    context '1 processor' do
      let(:cpus) do
        1
      end

      it 'get a test group' do
        tests_in_groups.size.should eq 1
      end
    end

    context '3 processors' do
      let(:cpus) do
        3
      end

      it 'get test groups' do
        expect_group1 = ['features/songs.feature', 'big_size_spec.rb']
        expect_group2 = ['features/battle.feature', 'features/small_size_spec.rb']
        expect_group3 = ['features/battle2.feature', 'features/battle3.feature']

        groups = tests_in_groups
        groups.size.should eq 3
        groups[0].should =~ expect_group1
        groups[1].should =~ expect_group2
        groups[2].should =~ expect_group3
      end
    end
  end

  context 'selected directory and pattern option' do
    let(:tests) do
      [helper.test_file_directory]
    end

    let(:options) do
      { :pattern => /songs/ }
    end

    describe '.find_features_and_specs' do
      it 'get specify pattern file' do
        actual_features, actual_specs = find_features_and_specs

        expect_features = [ 'features/songs.feature' ]

        actual_features.should =~ expect_features
        actual_specs.should be_empty
      end
    end

    context '1 processor' do
      let(:cpus) do
        1
      end

      it 'get a test group' do
        tests_in_groups.size.should eq 1
        tests_in_groups[0].size.should eq 1
      end
    end

    context '3 processors' do
      let(:cpus) do
        3
      end

      it 'get test groups' do
        expect_group1 = ['features/songs.feature']

        groups = tests_in_groups
        groups.size.should eq 3
        groups[0].should =~ expect_group1
        groups[1].should be_empty
        groups[2].should be_empty
      end
    end
  end

  context 'selected files' do
    let(:tests) do
      [
        helper.test_file_directory + '/features/battle.feature',
        helper.test_file_directory + '/features/battle2.feature',
        helper.test_file_directory + '/features/battle3.feature',
        helper.test_file_directory + '/features/battle2.feature', # duplication
        helper.test_file_directory + '/features/battle2.feature', # duplication
        helper.test_file_directory + '/features/battle.feature',  # duplication
      ]
    end

    let(:options) do
      { :pattern => /songs/ }
    end

    describe '.find_features_and_specs' do
      it 'get selected files' do
        actual_features, actual_specs = find_features_and_specs

        expect_features = [
          'features/battle.feature',
          'features/battle2.feature',
          'features/battle3.feature',
        ]

        actual_features.should =~ expect_features
        actual_specs.should be_empty
      end
    end

    context '1 processor' do
      let(:cpus) do
        1
      end

      it 'get a test group' do
        expect_group = [
          'features/battle.feature',
          'features/battle2.feature',
          'features/battle3.feature',
        ]

        tests_in_groups.size.should eq 1
        tests_in_groups[0].should =~ expect_group
      end
    end

    context '3 processors' do
      let(:cpus) do
        3
      end

      it 'get test groups' do
        expect_group1 = ['features/battle.feature']
        expect_group2 = ['features/battle2.feature']
        expect_group3 = ['features/battle3.feature']

        groups = tests_in_groups
        groups.size.should eq 3
        groups[0].should =~ expect_group1
        groups[1].should =~ expect_group2
        groups[2].should =~ expect_group3
      end
    end
  end
end
