# coding: utf-8
require "spec_helper"

describe StringMetric::Levenshtein::Experiment do
  it_behaves_like "Levenshtein Distance", { strategy: :experiment }
end