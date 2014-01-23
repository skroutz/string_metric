# StringMetric

[![Build Status](https://travis-ci.org/chief/string_metric.png?branch=master)](https://travis-ci.org/chief/string_metric)

A simple library with String Metric algorithms. If you want to read more about
String Metric algorithms please visit [this page](https://en.wikipedia.org/wiki/String_metric).

## Installation

This gem is under development. First version will be published 31/01/2014.

## Usage

### Levenshtein Distance

```ruby
  StringMetric::Levenshtein.distance("kitten", "sitting") # => 3

  # passing :max_distance option
  StringMetric::Levenshtein.distance("kitten", "sitting", max_distance: 2) # => 2

  # passing different costs for increase, delete, substitute actions
  StringMetric::Levenshtein.distance("kitten", "sitting", insertion_cost: 2,
    deletion_cost: 2, substitution_cost: 2) # => 6
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


## Contributing

1. Fork it ( http://github.com/<my-github-username>/string_metric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

string_metric is licensed under MIT. See [License](LICENSE.txt)