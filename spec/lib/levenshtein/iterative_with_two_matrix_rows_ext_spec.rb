# coding: utf-8

if RUBY_ENGINE == "ruby"
  require "spec_helper"

  describe StringMetric::Levenshtein::IterativeWithTwoMatrixRowsExt do
    it_behaves_like "Levenshtein Distance", { strategy: :two_matrix_rows_ext }
  end
end
