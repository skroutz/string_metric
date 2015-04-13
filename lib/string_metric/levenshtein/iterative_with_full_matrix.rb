# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithFullMatrix
      def self.distance(from, to, options = {})
        max_distance      = options[:max_distance]
        insertion_cost    = options.fetch(:insertion_cost, 1)
        deletion_cost     = options.fetch(:deletion_cost, 1)
        substitution_cost = options.fetch(:substitution_cost, 1)

        m = from.length
        n = to.length

        if max_distance && (m - n).abs >= max_distance
          return max_distance
        end

        return 0 if from == to
        return n if m.zero?
        return m if n.zero?

        d = (0..n).map do |i|
          [0] * (m + 1)
        end

        (1..m).each { |j| d[0][j] = j }
        (1..n).each { |i| d[i][0] = i }

        to_column = 0
        (1..m).each do |j|
          (1..n).each do |i|
            if from[j-1] == to[i-1]
              d[i][j] = d[i -1][j-1]
            else
              d[i][j] = [d[i-1][j]   + insertion_cost,    # insertion
                         d[i][j-1]   + deletion_cost,     # deletion
                         d[i-1][j-1] + substitution_cost  # substitution
                        ].min
            end
            to_column = i
          end

          break if max_distance and d[to_column].min > max_distance
        end

        x = d[n][m]
        if max_distance && x > max_distance
          max_distance
        else
          x
        end
      end
    end
  end
end
