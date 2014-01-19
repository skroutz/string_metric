# coding: utf-8

module StringMetric
  module Levenshtein
    class Experiment
      def self.distance(str1, str2, options = {})
        return 0 if str1 == str2
        return str2.size if str1.size.zero?
        return str1.size if str2.size.zero?

        m = str1.length
        n = str2.length

        [m, n].min.times do |i|
          if str1[i] == str2[i]
            str1.slice!(i)
            str2.slice!(i)
          end
        end

        options.delete(:strategy)
        Levenshtein.distance(str1, str2, options)
      end
    end
  end
end