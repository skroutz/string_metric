# coding: utf-8

require "spec_helper"

describe StringMetric::Levenshtein do
  describe ".distance" do
    context "when the two strings are equal" do
      it "is 0" do
        expect(described_class.distance("myrsini", "myrsini")).to eq 0
      end
    end

    context "when the first string is nil" do
      it "is the size of the second string" do
        expect(described_class.distance(nil, "μυρσίνη")).to eq("μυρσίνη".size)
      end
    end

    context "when the second string is nil" do
      it "is the size of the first string" do
        expect(described_class.distance("μυρσινάκι", nil)).to eq("μυρσινάκι".size)
      end
    end

    context "when the first string is empty" do
      it "is the size of the second string" do
        expect(described_class.distance("","myrsini")).to eq("myrsini".size)
      end
    end

    context "when the second string is empty" do
      it "is the size of the first string" do
        expect(described_class.distance("myrsini","")).to eq("myrsini".size)
      end
    end

    context "when recursive is used" do
      it "returns Levenshtein distance" do
        expect(described_class.distance("kitten", "sitting")).to eq 3
      end
    end
  end
end