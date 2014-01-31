# coding: utf-8

require_relative "levenshtein/experiment"
require_relative "levenshtein/iterative_with_two_matrix_rows"
require_relative "levenshtein/iterative_with_two_matrix_rows_optimized"
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
      two_matrix_rows:    IterativeWithTwoMatrixRows,
      two_matrix_rows_v2: IterativeWithTwoMatrixRowsOptimized
    }

    # Levenshtein Distance of two strings
    #
    # @param from [String] the first string
    # @param to [String] the second string
    # @param options [Hash] options
    # @option options [Fixnum, Float] :max_distance If this option is passed then
    #   levenstein distance is trimmed to this value (if greater)
    # @option options [Fixnum, Float] :insertion_cost If this option is passed then
    #   new insertion cost is taken into account (by default is 1)
    # @option options [Fixnum, Float] :deletion_cost If this option is passed then
    #   new deletion cost is taken into account (by default is 1)
    # @option options [Fixnum, Float] :substitution_cost If this option is passed then
    #   new substitution cost is taken into account (be default is 1)
    # @option options [Symbol] :strategy The desired strategy for Levenshtein
    #   distance. Supported strategies are :recursive, :two_matrix_rows,
    #   :full_matrix, :two_matrix_rows_v2 and :experiment. The default strategy
    #   is :two_matrix_rows_v2 for MRI and :two_matrix_rows for other platforms.
    #   One should not depend on :experiment strategy.
    # @return [Fixnum, Float] the Levenshtein Distance
    def distance(from, to, options = {})
      strategy = pick_strategy(options[:strategy]) || Levenshtein.default_strategy
      args = [from, to, options]

      strategy.distance(*args)
    end
    module_function :distance

    # Currently the default strategy is set to IterativeWithTwoMatrixRows
    def default_strategy
      if RUBY_ENGINE == "ruby"
        pick_strategy(:two_matrix_rows_v2)
      else
        pick_strategy(:two_matrix_rows)
      end
    end
    module_function :default_strategy

    def pick_strategy(symbol)
      STRATEGIES[symbol]
    end
    module_function :pick_strategy
    private_class_method :pick_strategy
  end
end
