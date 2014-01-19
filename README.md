# StringMetric

A simple library with String Metric algorithms. If you want to read more about
String Metric algorithms please visit [this page](https://en.wikipedia.org/wiki/String_metric).

## Installation

This gem is under development. First version will be published 31/01/2014.

## Usage

(coming soon)

## References

[Levenshtein Distance](https://en.wikipedia.org/wiki/Levenshtein_distance)
[String Metric][https://en.wikipedia.org/wiki/String_metric]

## Benchmarks

You can run benchmarks with

  $ bundle exec ruby benchmarks/*

or you can choose to benchmark a specific algorithm like:

  $ bundle exec ruby benchmarks/levenshtein.rb

## Current Benchmarks status

_Levenshtein_

Currentyl the set of fixtures is very small

Implementation                              | User      | Real
--------------------------------------------|-----------|-----------
Levenshtein::IterativeWithFullMatrix        | 0.480000  | 0.475662
Levenshtein::IterativeWithTwoMatrixRows     | 0.350000  | 0.352388
Levenshtein::Experiment                     | 0.420000  | 0.420000
Text::Levenshtein (from gem text)           | 0.400000  | 0.400346

## Other implementations

_Levenshtein_

* this beautiful gem, [text](https://github.com/threedaymonk/text)


## Contributing

1. Fork it ( http://github.com/<my-github-username>/string_metric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licence

string_metric is licensed under MIT. See [License](LICENSE.txt)