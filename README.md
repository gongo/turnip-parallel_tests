# Turnip::ParallelTests

Helper [parallel_tests](https://github.com/grosser/parallel_tests) for [turnip](https://github.com/jnicklas/turnip).

## Motivation

I wanted to run a turnip project using `parallel_rspec`.
However, `parallel_rspec` didn't find `.feature` files. (if specify option `--pattern .feature`, they are ignored when no one is `spec/**/*_spec.rb`)

So, I made this gem that will run if there is `_spec.rb` or `.feature` file to specified directories.

## Installation

Add this line to your application's Gemfile:

    gem 'turnip-parallel_tests'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turnip-parallel_tests

## Usage

Add `--type turnip` (or `-t turnip`) to the commands:

    $ parallel_rspec -n 3 --type turnip spec

## License

see `LICENSE.txt`
