# coding: utf-8
require "spec_helper"

describe StringMetric::Levenshtein::IterativeWithTwoMatrixRowsOptimized do
  it_behaves_like "Levenshtein Distance", { strategy: :two_matrix_rows_v2 }
end
