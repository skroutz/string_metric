require "benchmark"
require "string_metric"
require "text"

Benchmark.bmbm(7) do |x|

  iterations = 10_000

  x.report("Recursive implementation") do
    (1..100).each do |i|
      StringMetric::Levenshtein.distance("kitten", "sitting", strategy: :recursive)
    end
  end

  x.report("Full Matrix implementation") do
    iterations.times do |i|
      StringMetric::Levenshtein.distance("kitten", "sitting", strategy: :full_matrix)
    end
  end

  x.report("Two Matrix rows implementation") do
    iterations.times do |i|
      StringMetric::Levenshtein.distance("kitten", "sitting", strategy: :two_matrix_rows)
    end
  end

  x.report("Experiment implementation") do
    iterations.times do |i|
      StringMetric::Levenshtein.distance("kitten", "sitting", strategy: :experiment)
    end
  end

  x.report("Text::Levenshtein implementation") do
    iterations.times do |i|
      Text::Levenshtein.distance("kitten", "sitting")
    end
  end
end
