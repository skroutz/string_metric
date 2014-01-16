require "benchmark"
require "string_metric"
require "text"

Benchmark.bmbm(7) do |x|
  x.report("Recursive implementation") do
    (1..100).each do |i|
      StringMetric::Levenshtein.distance("kitten", "sitting")
    end
  end

  x.report("Text::Levenshtein implementation") do
    (1..100).each do |i|
      Text::Levenshtein.distance("kitten", "sitting")
    end
  end
end
