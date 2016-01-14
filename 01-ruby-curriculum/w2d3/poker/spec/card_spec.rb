require "rspec"
require "card"

describe Card do
  subject(:card) { Card.new(12, :hearts) }

  describe "#initialize" do
    it "initializes with the suit and value passed in" do
      expect(card.value).to eq(12)
      expect(card.suit).to eq(:hearts)
    end
  end

  describe "#to_s" do
    it "gives the correct string representation of card" do
      expect(card.to_s).to eq("Q\u2665")
    end
  end

  it "throws an error when trying to set either value or suit" do
    expect { card.value = 5 }.to raise_error(NoMethodError)
    expect { card.suit = :spades }.to raise_error(NoMethodError)
  end
end
