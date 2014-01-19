# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithFullMatrix
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        max_distance = options[:max_distance]

        d = (0..to.size).map do |i|
          [0] * (from.size + 1)
        end

        (1..from.size).to_a.each { |j| d[0][j] = j }
        (1..to.size).to_a.each { |i| d[i][0] = i }

        (1..from.size).to_a.each do |j|
          (1..to.size).to_a.each do |i|
            if from[j-1] == to[i-1]
              d[i][j] = d[i -1][j-1]
            else
              d[i][j] = [d[i-1][j] + 1,   # deletion
                         d[i][j-1] + 1,   # insertion
                         d[i-1][j-1] + 1  # substitution
                        ].min
            end
          end

          break if max_distance and d[j][j] > max_distance
        end

        x = d[to.size][from.size]
        if max_distance && x > max_distance
          max_distance
        else
          x
        end
      end
    end
  end
end