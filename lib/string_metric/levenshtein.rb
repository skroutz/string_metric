# coding: utf-8

require_relative "levenshtein/experiment"
require_relative "levenshtein/iterative_with_two_matrix_rows"
require_relative "levenshtein/iterative_with_full_matrix"
require_relative "levenshtein/recursive"

module StringMetric
  module Levenshtein

    STRATEGIES = {
      experiment:   Experiment,
      full_matrix:  IterativeWithFullMatrix,
      recursive:    Recursive,
      two_matrix_rows: IterativeWithTwoMatrixRows,
    }

    def distance(str1, str2, options = {})
      strategy = pick_strategy(options[:strategy]) || Levenshtein.default
      args = [str1, str2, options]

      strategy.distance(*args)
    end
    module_function :distance

    def default
      pick_strategy(:two_matrix_rows)
    end
    module_function :default

    def pick_strategy(symbol)
      STRATEGIES[symbol]
    end
    module_function :pick_strategy
    private_class_method :pick_strategy
  end
end