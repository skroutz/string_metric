# coding: utf-8

module StringMetric
  module Levenshtein
    def distance(a, b)
      return 0 if a == b
      return b.size if a.nil? || a.empty?
      return a.size if b.nil? || b.empty?

      recursive(a, b)
    end
    module_function :distance

    def recursive(a, b)
      return b.size if a.size.zero?
      return a.size if b.size.zero?

      if a.chars.last == b.chars.last
        cost = 0
      else
        cost = 1
      end

      return [recursive(a.chop, b) + 1,
              recursive(a, b.chop) + 1,
              recursive(a.chop, b.chop) + cost].min

    end
    module_function :recursive
    private_class_method :recursive
  end
end