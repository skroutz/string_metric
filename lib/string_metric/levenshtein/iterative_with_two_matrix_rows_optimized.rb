# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRowsOptimized
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        max_distance      = options[:max_distance]
        insertion_cost    = options[:insertion_cost]    || 1
        deletion_cost     = options[:deletion_cost]     || 1
        substitution_cost = options[:substitution_cost] || 1

        m = from.length
        n = to.length

        from = from.codepoints.to_a
        to = to.codepoints.to_a

        v0 = (0..m).to_a
        x = 0

        n.times do |i|
          current = x = i + 1
          sub_cell = v0[0]

          m.times do |j|
            cost = (from[j] == to[i]) ? 0 : substitution_cost
            ins_cell = v0[j + 1]

            x = [current + deletion_cost,   # deletion
                 ins_cell + insertion_cost, # insertion
                 sub_cell + cost            # substitution
                ].sort![0]

            v0[j] = current
            current = x
            sub_cell = ins_cell
          end

          v0[m] = x
          break if max_distance && v0.sort[0] > max_distance
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
