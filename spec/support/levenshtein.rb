require "csv"

shared_examples "Levenshtein Distance" do |options|
  options ||= {}

  describe ".distance" do
    context "when the two strings are equal" do
      it "is 0" do
        expect(described_class.distance("kitten", "kitten", options)).to eq 0
      end
    end

    context "when the first string is empty" do
      it "is the size of the second string" do
        expect(described_class.distance("","kitten", options)).to eq("kitten".size)
      end
    end

    context "when the second string is empty" do
      it "is the size of the first string" do
        expect(described_class.distance("kitten","", options)).to eq("kitten".size)
      end
    end

    context "when max_distance is passed as option" do
      context "and normal distance is greater than max_distance" do
        it "is trimmed to max_distance" do
          expect(described_class.distance("gumbo", "gambol", max_distance: 1)).to eq 1
          expect(described_class.distance("test", "tasf", max_distance: 1)).to eq 1
          expect(described_class.distance("kitten", "sitting", max_distance: 2)).to eq 2
          expect(described_class.distance("kitten", "kittenss", max_distance: 1)).to eq 1
          expect(described_class.distance("kittenss", "kitten", max_distance: 1)).to eq 1
          expect(described_class.distance("sitting", "kitten", max_distance: 2)).to eq 2
          expect(described_class.distance("gambol", "gumbo", max_distance: 1)).to eq 1
          expect(described_class.distance("kitten", "", max_distance: 2)).to eq 2
          expect(described_class.distance("", "kitten", max_distance: 3)).to eq 3
        end
      end
      context "and normal distance is less than max_distance" do
        it "is calculated distance" do
          expect(described_class.distance("", "t", max_distance: 2)).to eq 1
          expect(described_class.distance("t", "", max_distance: 3)).to eq 1
          expect(described_class.distance("test", "test", max_distance: 1)).to eq 0
          expect(described_class.distance("test", "tent", max_distance: 2)).to eq 1
          expect(described_class.distance("gumbo", "gambol", max_distance: 3)).to eq 2
          expect(described_class.distance("kitten", "sitting", max_distance: 4)).to eq 3
          expect(described_class.distance("kitten", "kittenss", max_distance: 4)).to eq 2
          expect(described_class.distance("kittenss", "kitten", max_distance: 4)).to eq 2
          expect(described_class.distance("sitting", "kitten", max_distance: 4)).to eq 3
          expect(described_class.distance("gambol", "gumbo", max_distance: 3)).to eq 2
          expect(described_class.distance("", "cat", max_distance: 4)).to eq 3
          expect(described_class.distance("cat", "", max_distance: 5)).to eq 3
          expect(described_class.distance("", "", max_distance: 2)).to eq 0
        end
      end
      context "and normal distance is same as max_distance" do
        it "is calculated distance" do
          expect(described_class.distance("test", "test", max_distance: 0)).to eq 0
          expect(described_class.distance("test", "tent", max_distance: 1)).to eq 1
          expect(described_class.distance("gumbo", "gambol", max_distance: 2)).to eq 2
          expect(described_class.distance("kitten", "sitting", max_distance: 3)).to eq 3
          expect(described_class.distance("kitten", "kittenss", max_distance: 2)).to eq 2
          expect(described_class.distance("kittenss", "kitten", max_distance: 2)).to eq 2
          expect(described_class.distance("sitting", "kitten", max_distance: 3)).to eq 3
          expect(described_class.distance("gambol", "gumbo", max_distance: 2)).to eq 2
          expect(described_class.distance("", "cat", max_distance: 3)).to eq 3
          expect(described_class.distance("cat", "", max_distance: 3)).to eq 3
          expect(described_class.distance("", "", max_distance: 0)).to eq 0
        end
      end
    end

    CSV.foreach("spec/fixtures/levenshtein.csv") do |row|
      from, to, distance = row
      from = from.to_s.strip
      to   = to.to_s.strip

      it "calculates the distance from '#{from}' to '#{to}' correctly" do
        expect(described_class.distance(from, to, options)).to eq distance.to_i
      end
    end

    context "when insertion_cost is passed" do
      it "takes this cost into account" do
        expect(described_class.distance("kitten", "sitting", insertion_cost: 1)).not_to eq(
        described_class.distance("kitten", "sitting", insertion_cost: 2))
      end
    end
  end
end
