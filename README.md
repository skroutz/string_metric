# StringMetric

[![Build Status](https://travis-ci.org/skroutz/string_metric.png?branch=master)](https://travis-ci.org/skroutz/string_metric)
[![Code Climate](https://codeclimate.com/github/skroutz/string_metric.png)](https://codeclimate.com/github/skroutz/string_metric)
[![Coverage Status](https://coveralls.io/repos/skroutz/string_metric/badge.png?branch=master)](https://coveralls.io/r/skroutz/string_metric?branch=master)
[![Gem Version](https://badge.fury.io/rb/string_metric.png)](http://badge.fury.io/rb/string_metric)

A simple library with String Metric algorithms. If you want to read more about
String Metric algorithms please read [here](https://en.wikipedia.org/wiki/String_metric).

This library wants to support __MRI__ (1.9.3, 2.0.0, 2.1.0), __JRuby__ and
__Rubinious__.

## Installation

Add this line to your application's Gemfile:

    gem 'string_metric'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install string_metric

## Usage

### Levenshtein Distance

The public api for Levenshtein Distance is the method
`StringMetric::Levenshtein.distance`.

__Options__

* `:max_distance`: It sets an upper limit for the calculated distance. Can be
  `Fixnum` or `Float`.

* `:insertion_cost`: It overrides the default (equals to 1) insertion penalty.
   Can be `Fixnum` or `Float`.

* `:deletion_cost`: It overrides the default (equals to 1) deletion penanty.
  Can be `Fixnum` or `Float`.

* `:subsctitution_cost`: It overrides the default (equals to 1) substitution
  penalty. Can be `Fixum` or `Float`.

* `:strategy`: The desired strategy for Levenshtein distance. Supported
  strategies are `:recursive`, `:two_matrix_rows`, `:full_matrix` and
  `:experiment`. The default strategy is `:two_matrix_rows`. One should not
  depend on `:experiment` strategy.

__Examples__

```ruby

  require 'string_metric'

  StringMetric::Levenshtein.distance("kitten", "sitting")
  # Generates: 3

  # Trim distance to :max_distance
  StringMetric::Levenshtein.distance("kitten", "sitting",
    max_distance: 2)
  # Generates: 2

  # Pass different costs for increase, delete or substitute actions
  StringMetric::Levenshtein.distance("kitten", "sitting",
    insertion_cost: 2,
    deletion_cost:  2,
    substitution_cost: 2)
  # Generates: 6

```

## References

* [Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance)
* [String Metric](https://en.wikipedia.org/wiki/String_metric)

## Benchmarks

You can run benchmarks with

```
  $ bundle exec ruby benchmarks/*
```

or you can choose to benchmark a specific algorithm like:

```
  $ bundle exec ruby benchmarks/levenshtein.rb
```

## Current Benchmarks status

__Levenshtein__

Implementation                                   | User      | Real
-------------------------------------------------|-----------|-----------
Levenshtein::IterativeWithFullMatrix             | 1.490000  | 1.502395
Levenshtein::IterativeWithTwoMatrixRows          | 1.240000  | 1.241995
Levenshtein::Experiment                          | 1.400000  | 1.397641
Levenshtein::IterativeWithTwoMatrixRowsOptimized | 1.110000  | 1.115596
Text::Levenshtein (from gem text)                | 1.360000  | 1.371572

_Currently the set of fixtures is very small - ruby 2.1.0 is used_

## Other implementations

__Levenshtein__

* this beautiful gem, [text](https://github.com/threedaymonk/text)
* ffi implementations, like [this](https://github.com/dbalatero/levenshtein-ffi) or check [The Ruby Toolbox](https://www.ruby-toolbox.com/projects/levenshtein-ffi)

__Various__
* Approximate String matching [library](https://github.com/flori/amatch)

## Tools

* Try to use [SemVer](http://semver.org/)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/string_metric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

string_metric is licensed under MIT. See [License](LICENSE.txt)