# StringMetric

[![Build Status](https://travis-ci.org/skroutz/string_metric.png?branch=master)](https://travis-ci.org/skroutz/string_metric)
[![Code Climate](https://codeclimate.com/github/skroutz/string_metric.png)](https://codeclimate.com/github/skroutz/string_metric)
[![Coverage Status](https://coveralls.io/repos/skroutz/string_metric/badge.png)](https://coveralls.io/r/skroutz/string_metric?branch=master)

A simple library with String Metric algorithms. If you want to read more about
String Metric algorithms please read [here](https://en.wikipedia.org/wiki/String_metric).

This library wants to support __MRI__ (1.9.3, 2.0.0, 2.1.0), __JRuby__ and
__Rubinious__.

## Installation

This gem is under development. First version will be published 31/01/2014.

## Usage

### Levenshtein Distance

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


Implementation                              | User      | Real
--------------------------------------------|-----------|-----------
Levenshtein::IterativeWithFullMatrix        | 0.480000  | 0.475662
Levenshtein::IterativeWithTwoMatrixRows     | 0.350000  | 0.352388
Levenshtein::Experiment                     | 0.420000  | 0.420000
Text::Levenshtein (from gem text)           | 0.400000  | 0.400346

_Currently the set of fixtures is very small_

## Other implementations

__Levenshtein__

* this beautiful gem, [text](https://github.com/threedaymonk/text)
* ffi implementations, like [this](https://github.com/dbalatero/levenshtein-ffi) or check [The Ruby Toolbox](https://www.ruby-toolbox.com/projects/levenshtein-ffi)

__Various__
* Approximate String matching [library](https://github.com/flori/amatch)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/string_metric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

string_metric is licensed under MIT. See [License](LICENSE.txt)