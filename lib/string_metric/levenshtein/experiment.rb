# coding: utf-8

module StringMetric
  module Levenshtein
    class Experiment
      def self.distance(from, to, options = {})
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
