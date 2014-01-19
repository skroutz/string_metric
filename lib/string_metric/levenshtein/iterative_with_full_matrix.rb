# coding: utf-8

module StringMetric
  module Levenshtein
    class IterativeWithFullMatrix
      def self.distance(str1, str2, options = {})
        return 0 if str1 == str2
        return str2.size if str1.size.zero?
        return str1.size if str2.size.zero?

        d = (0..str2.size).map do |i|
          [0] * (str1.size + 1)
        end

        (1..str1.size).to_a.each { |j| d[0][j] = j }
        (1..str2.size).to_a.each { |i| d[i][0] = i }

        (1..str1.size).to_a.each do |j|
          (1..str2.size).to_a.each do |i|
            if str1[j-1] == str2[i-1]
              d[i][j] = d[i -1][j-1]
            else
              d[i][j] = [d[i-1][j] + 1,
                         d[i][j-1] + 1,
                         d[i-1][j-1] + 1].min
            end
          end
        end

        d[str2.size][str1.size]
      end
    end
  end
end