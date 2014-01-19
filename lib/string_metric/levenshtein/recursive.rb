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

        return [distance(from.chop, to) + 1,
                distance(from, to.chop) + 1,
                distance(from.chop, to.chop) + cost].min
      end
    end
  end
end