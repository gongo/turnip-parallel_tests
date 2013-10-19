# Turnip::ParallelTests

Helper [parallel_tests](https://github.com/grosser/parallel_tests) for [turnip](https://github.com/jnicklas/turnip).

[![Build Status](https://travis-ci.org/gongo/turnip-parallel_tests.png?branch=master)](https://travis-ci.org/gongo/turnip-parallel_tests)

[![Coverage Status](https://coveralls.io/repos/gongo/turnip-parallel_tests/badge.png)](https://coveralls.io/r/gongo/turnip-parallel_tests)



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

## About grouping of tests.

Group tests by:

* `.feature`: number of steps.
* `_spec.rb`: file size.

eg:

```sh
$ ls spec
features/battle1.feature # 12 steps.
features/battle2.feature #  8 steps.
features/battle3.feature #  4 steps.
features/battle4.feature #  6 steps.
```

When 3 cpus:

```sh
$ parallel_rspec -n 3 --type turnip spec
```

* thread1: `battle1.feature`
* thread2: `battle2.feature`
* thread3: `battle3.feature` , `battle4.feature`

## License

see `LICENSE.txt`
