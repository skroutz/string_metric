# coding: utf-8

module StringMetric
  module Levenshtein
    class Experiment
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        m = from.length
        n = to.length

        [m, n].min.times do |i|
          if from[i] == to[i]
            from.slice!(i)
            to.slice!(i)
          end
        end

        options.delete(:strategy)

        # Call default distance implementation
        Levenshtein.distance(from, to, options)
      end
    end
  end
end