# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithTwoMatrixRows
      def self.distance(str1, str2, options = {})
        return 0 if str1 == str2
        return str2.size if str1.size.zero?
        return str1.size if str2.size.zero?

        m = str1.length
        n = str2.length

        v0 = (0..m).to_a
        v1 = []

        n.times do |i|
          v1[0] = i + 1

          m.times do |j|
            cost = (str1[j] == str2[i]) ? 0 : 1

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