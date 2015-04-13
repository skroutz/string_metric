# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRows
      def self.distance(from, to, options = {})
        max_distance      = options[:max_distance]
        insertion_cost    = options.fetch(:insertion_cost, 1)
        deletion_cost     = options.fetch(:deletion_cost, 1)
        substitution_cost = options.fetch(:substitution_cost, 1)

        m = from.length
        n = to.length

        if max_distance && (n - m).abs >= max_distance
          return max_distance
        end

        return 0 if from == to
        return n if m.zero?
        return m if n.zero?

        v0 = (0..m).to_a
        x = 0

        n.times do |i|
          current = x = i + 1
          sub_cell = v0[0]

          m.times do |j|
            cost = (from[j] == to[i]) ? 0 : substitution_cost

            ins_cell = v0[j+1]

            x = [current + deletion_cost,   # deletion
                 ins_cell + insertion_cost, # insertion
                 sub_cell + cost            # substitution
                ].min

            v0[j] = current
            current = x
            sub_cell = ins_cell
          end

          v0[m] = x
          break if max_distance && v0.min > max_distance
        end

        if max_distance && x > max_distance
          max_distance
        else
          x
        end
      end
    end
  end
end
