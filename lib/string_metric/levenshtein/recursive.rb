# coding: utf-8

module StringMetric
  module Levenshtein
    class Recursive
      def self.distance(str1, str2, options = {})
        return 0 if str1 == str2
        return str2.size if str1.size.zero?
        return str1.size if str2.size.zero?

        if str1.chars.last == str2.chars.last
          cost = 0
        else
          cost = 1
        end

        return [distance(str1.chop, str2) + 1,
                distance(str1, str2.chop) + 1,
                distance(str1.chop, str2.chop) + cost].min
      end
    end
  end
end