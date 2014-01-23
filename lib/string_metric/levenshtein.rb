# coding: utf-8

require_relative "levenshtein/experiment"
require_relative "levenshtein/iterative_with_two_matrix_rows"
require_relative "levenshtein/iterative_with_full_matrix"
require_relative "levenshtein/recursive"

module StringMetric
  # Levenshtein Distance implementation
  #
  # @see https://en.wikipedia.org/wiki/Levenshtein_distance
  module Levenshtein

    STRATEGIES = {
      experiment:   Experiment,
      full_matrix:  IterativeWithFullMatrix,
      recursive:    Recursive,
      two_matrix_rows: IterativeWithTwoMatrixRows
    }

    # Levenshtein Distance of two strings
    #
    # @param from [String] the first string
    # @param to [String] the second string
    # @param options [Hash] options
    # @return [Integer] the Levenshtein Distance
    def distance(from, to, options = {})
      strategy = pick_strategy(options[:strategy]) || Levenshtein.default_strategy
      args = [from, to, options]

      strategy.distance(*args)
    end
    module_function :distance

    def default_strategy
      pick_strategy(:two_matrix_rows)
    end
    module_function :default_strategy

    def pick_strategy(symbol)
      STRATEGIES[symbol]
    end
    module_function :pick_strategy
    private_class_method :pick_strategy
  end
end