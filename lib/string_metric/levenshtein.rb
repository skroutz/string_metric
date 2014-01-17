# coding: utf-8

module StringMetric
  module Levenshtein
    def distance(a, b, options = {})
      return 0 if a == b
      return b.size if a.nil? || a.empty?
      return a.size if b.nil? || b.empty?

      case options[:strategy]
      when :recursive
        recursive(a, b)
      when :full_matrix
        iterative_with_full_matrix(a, b)
      when :two_matrix_rows
        iterative_with_two_matrix_rows(a, b)
      when :recursive_memoized
        recursive_memoized(a, b)
      end
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

    def recursive_memoized(a, b)
      return @_memoize[a][b] if !@_memoize.nil? && !@_memoize[a][b].nil?
      @_memoize ||= []


      @_memoize[a][b] =
        if a.size.zero?
          b.size
        elsif b.size.zero?
          a.size
        else
          if a.chars.last == b.chars.last
            cost = 0
          else
            cost = 1
          end

          [recursive_memoized(a.chop, b) + 1,
           recursive_memoized(a, b.chop) + 1,
           recursive_memoized(a.chop, b.chop) + cost].min
        end

      return @_memoize[a][b]
    end
    module_function :recursive_memoized
    private_class_method :recursive_memoized

    def iterative_with_full_matrix(a, b)
      d = (0..b.size).map do |i|
        [0] * (a.size + 1)
      end

      (1..a.size).to_a.each { |j| d[0][j] = j }
      (1..b.size).to_a.each { |i| d[i][0] = i }

      (1..a.size).to_a.each do |j|
        (1..b.size).to_a.each do |i|
          if a[j-1] == b[i-1]
            d[i][j] = d[i -1][j-1]
          else
            d[i][j] = [d[i-1][j] + 1,
                       d[i][j-1] + 1,
                       d[i-1][j-1] + 1].min
          end
        end
      end

      d[b.size][a.size]
    end
    module_function :iterative_with_full_matrix
    private_class_method :iterative_with_full_matrix

    def iterative_with_two_matrix_rows(a, b)
      v0 = []
      v1 = []

      v0 = (0..b.size).to_a

      m = a.size
      n = b.size

      (m + 1).times do |i|
        v1[0] = i + 1

        n.times do |j|
          cost = a[i] == b[j] ? 0 : 1
          v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost].min
        end

        v0 = v1.dup
      end

      v1.last
    end
    module_function :iterative_with_two_matrix_rows
    private_class_method :iterative_with_two_matrix_rows

  end
end