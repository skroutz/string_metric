require "benchmark"
require "string_metric"
require "text"
require "pry"
require "csv"

Benchmark.bmbm(7) do |x|

  iterations = 10_000
  options = { insertion_cost: 2 }

  fixtures = []
  CSV.foreach("spec/fixtures/levenshtein.csv") do |row|
    from, to, _ = row

    fixtures.push [from.to_s.strip, to.to_s.strip]
  end

  StringMetric::Levenshtein::STRATEGIES.each do |strategy, implementation|
    next if strategy == :recursive

    x.report("#{implementation.to_s} implementation") do
      iterations.times do |i|

        fixtures.each do |from, to|
          implementation.distance(from, to, options)
        end
      end
    end
  end

  x.report("Text::Levenshtein implementation") do
    iterations.times do |i|
      fixtures.each do |from, to|
        Text::Levenshtein.distance(from, to)
      end
    end
  end
end
