# coding: utf-8

require_relative "iterative_with_two_matrix_rows_ext.so"

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRowsExt
      def self.distance(from, to, options = {})
        max_distance      = options[:max_distance]
        insertion_cost    = options[:insertion_cost]    || 1
        deletion_cost     = options[:deletion_cost]     || 1
        substitution_cost = options[:substitution_cost] || 1

        from_len = from.length
        to_len =   to.length

        if max_distance && (to_len - from_len).abs >= max_distance
            return max_distance
        end

        return 0 if from == to
        return to_len if from_len.zero?
        return from_len if to_len.zero?

        from = from.codepoints.to_a
        to = to.codepoints.to_a

        distance_ext(from, to, from_len, to_len, max_distance || 0, insertion_cost,
                     deletion_cost, substitution_cost)
      end
    end
  end
end
