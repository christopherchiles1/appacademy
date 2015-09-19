require 'rspec'
require 'hand'

describe Hand do
  subject(:hand) { Hand.new }
  let(:queen_of_spades) { double("queen_of_spades", to_s: "Q\u2660", value: 12, suit: :spades) }
  let(:ten_of_diamonds) { double("ten_of_diamonds", to_s: "10\u2666") }
  let(:jack_of_clubs) { double("jack_of_clubs", to_s: "J\u2663") }
  let(:ace_of_spades) { double("ace_of_spades", value: 14, suit: :spades) }
  let(:king_of_spades) { double("king_of_spades", value: 13, suit: :spades) }
  let(:jack_of_spades) { double("jack_of_spades", value: 11, suit: :spades) }
  let(:ten_of_spades) { double("ten_of_spades", value: 10, suit: :spades) }

  describe "::compare_hands" do

  end

  describe "#initialize" do
    it "does not raise an error" do
      expect { hand }.to_not raise_error
    end
  end

  it "can be read" do
    expect { hand.cards }.to_not raise_error
  end

  describe "#to_s" do
    it "returns the hand as a string" do
      hand.cards << queen_of_spades << ten_of_diamonds << jack_of_clubs

      expect(hand.to_s).to eq("Q\u2660, 10\u2666, J\u2663")
    end
  end

  describe "#royal_flush?" do
    it "returns true if hand is royalty" do
      cards = [ace_of_spades, king_of_spades, queen_of_spades, jack_of_spades, ten_of_spades]
      cards.each { |card| hand.cards << card }

      expect(hand).to be_royal_flush
    end
  end

  describe "#straight_flush?" do

  end

  describe "#four_kind?" do
  end

  describe "#full_house?" do
  end

  describe "#flush?" do
  end

  describe "#straight?" do
  end

  describe "#three_kind?" do
  end

  describe "#two_pair?" do

  end

  describe "#one_pair?" do
  end

  describe "#high_card?" do
  end

end
