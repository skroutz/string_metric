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

        max_distance = options[:max_distance]

        x = 0

        n.times do |i|
          x = v1[0] = i + 1

          sub_cell = v0[0]

          m.times do |j|
            cost = (from[j] == to[i]) ? 0 : 1

            ins_cell = v0[j+1]

            x = [x + 1,           # deletion
                 ins_cell + 1,    # insertion
                 sub_cell + cost  # substitution
                 ].min


            v1[j + 1] = x

            sub_cell = ins_cell
          end

          break if max_distance && v0[i] > max_distance

          v0 = v1.dup
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