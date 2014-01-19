# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRows
      def self.distance(from, to, options = {})
        return 0 if from == to
        return to.size if from.size.zero?
        return from.size if to.size.zero?

        m = from.length
        n = to.length

        v0 = (0..m).to_a
        v1 = []

        n.times do |i|
          v1[0] = i + 1

          m.times do |j|
            cost = (from[j] == to[i]) ? 0 : 1

            v1[j + 1] = [v1[j] + 1,
                             v0[j  + 1] + 1,
                             v0[j] + cost].min
          end

          v0 = v1.dup
        end

        v1[-1]
      end
    end
  end
end