require "benchmark"
require "string_metric"
require "text"
require "pry"

Benchmark.bmbm(7) do |x|

  iterations = 1_000

  options = {}

  StringMetric::Levenshtein::STRATEGIES.each do |strategy, implementation|
    x.report("#{implementation.to_s} implementation") do
      iterations.times do |i|
        implementation.distance("kitten", "sitting", options)
      end
    end
  end

  x.report("Text::Levenshtein implementation") do
    iterations.times do |i|
      Text::Levenshtein.distance("kitten", "sitting")
    end
  end
end
