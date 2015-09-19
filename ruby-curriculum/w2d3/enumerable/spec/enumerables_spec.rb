require "rspec"
require "enumerables"

describe Array do
  let(:array_with_dups) { [-3, 3, 5, 3, 5] }
  let(:empty_array) { Array.new }
  let(:array) { [1, 3, 2, 4] }

  describe "#my_uniq" do
    context "when called on an empty array" do
      it "returns an empty array" do
        expect(empty_array.my_uniq).to eq(empty_array)
      end
    end

    context "when called on an array with duplicates" do
      it "returns an array of uniq values" do
        expect(array_with_dups.my_uniq).to eq(array_with_dups.uniq)
      end
    end

    context "when called on an array with no duplicates" do
      it "returns an array with the same values" do
        expect(array.my_uniq).to eq(array)
      end
    end
  end

  describe "#two_sum" do
    it "returns [] when no two elements sum to 0" do
      expect(array.two_sum).to eq(empty_array)
    end

    it "returns correct positions when there are elements that sum to 0" do
      expect(array_with_dups.two_sum).to eq([[0, 1], [0, 3]])
    end
  end
end
