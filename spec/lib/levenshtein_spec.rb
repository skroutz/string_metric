# coding: utf-8

require "spec_helper"

describe StringMetric::Levenshtein do
  it_behaves_like "Levenshtein Distance"

  describe '#default_strategy' do
    it "has a default strategy" do
      expect(described_class.default_strategy).to be
    end
  end
end