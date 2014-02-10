# coding: utf-8

require_relative "iterative_with_two_matrix_rows_ext.so"

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRowsExt
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        max_distance      = options[:max_distance]      || 0
        insertion_cost    = options[:insertion_cost]    || 1
        deletion_cost     = options[:deletion_cost]     || 1
        substitution_cost = options[:substitution_cost] || 1

        from_len = from.length
        to_len =   to.length

        from = from.codepoints.to_a
        to = to.codepoints.to_a

        distance_ext(from, to, from_len, to_len, max_distance, insertion_cost,
                     deletion_cost, substitution_cost)
      end
    end
  end
end
