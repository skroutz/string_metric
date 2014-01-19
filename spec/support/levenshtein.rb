shared_examples "Levenshtein Distance" do
  describe ".distance" do
    context "when the two strings are equal" do
      it "is 0" do
        expect(described_class.distance("kitten", "kitten")).to eq 0
      end
    end

    context "when the first string is empty" do
      it "is the size of the second string" do
        expect(described_class.distance("","kitten")).to eq("kitten".size)
      end
    end

    context "when the second string is empty" do
      it "is the size of the first string" do
        expect(described_class.distance("kitten","")).to eq("kitten".size)
      end
    end

    context "when :recursive is used" do
      let(:options) { { strategy: :recursive } }

      it "returns Levenshtein distance" do
        expect(described_class.distance("kitten", "sitting", options)).to eq 3
      end
    end

    context "when :full_matrix is used" do
      let(:options) { { strategy: :full_matrix } }

      it "returns Levenshtein distance" do
        expect(described_class.distance("kitten", "sitting", options)).to eq 3
      end
    end

    context "when :two_matrix_rows is used" do
      let(:options) { { strategy: :two_matrix_rows } }

      it "returns Levenshtein distance" do
        expect(described_class.distance("kitten", "sitting", options)).to eq 3
      end
    end

    context "when :experiment is used" do
      let(:options) { { strategy: :experiment } }

      it "returns Levenshtein distance" do
        expect(described_class.distance("kitten", "sitting", options)).to eq 3
      end
    end
  end
end
