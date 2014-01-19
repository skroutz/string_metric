# coding: utf-8

module StringMetric
  module Levenshtein
    class Recursive
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        if from.chars.last == to.chars.last
          cost = 0
        else
          cost = 1
        end

        max_distance = options[:max_distance]

        if max_distance
          return [distance(from.chop, to, options) + 1,
                  distance(from, to.chop, options) + 1,
                  distance(from.chop, to.chop, options) + cost,
                  max_distance].min
        else
          return [distance(from.chop, to, options) + 1,
                  distance(from, to.chop, options) + 1,
                  distance(from.chop, to.chop, options) + cost].min

        end
      end
    end
  end
end