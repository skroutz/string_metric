# coding: utf-8

module StringMetric
  module Levenshtein
    class Recursive
      def self.distance(from, to, options = {})
        max_distance      = options[:max_distance]
        insertion_cost    = options.fetch(:insertion_cost, 1)
        deletion_cost     = options.fetch(:deletion_cost, 1)
        substitution_cost = options.fetch(:substitution_cost, 1)

        if max_distance && (from.size - to.size).abs >= max_distance
          return max_distance
        end

        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        if from.chars.to_a.last == to.chars.to_a.last
          cost = 0
        else
          cost = substitution_cost
        end

        if max_distance
          return [distance(from.chop, to, options) + deletion_cost,
                  distance(from, to.chop, options) + insertion_cost,
                  distance(from.chop, to.chop, options) + cost,
                  max_distance
                 ].min
        else
          return [distance(from.chop, to, options) + deletion_cost,
                  distance(from, to.chop, options) + insertion_cost,
                  distance(from.chop, to.chop, options) + cost
                 ].min

        end
      end
    end
  end
end
