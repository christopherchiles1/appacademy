require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new_standard_deck }
  let(:custom_deck) { Deck.new(cards) }
  let(:empty_deck) { Deck.new([]) }
  let(:ace_of_hearts) { double("ace_of_hearts") }
  let(:queen_of_spades) { double("queen_of_spades") }
  let(:ten_of_clubs) { double("ten_of_clubs") }
  let(:cards) { [ace_of_hearts, queen_of_spades, ten_of_clubs] }

  describe "#initialize" do
    context "when passed a deck of cards" do

      it "uses the deck of cards" do
        new_cards = cards.dup
        result = []
        cards.length.times { result << custom_deck.draw }

        expect(result.reverse).to eq(new_cards)
      end
    end
  end

  describe "::new_standard_deck" do
    it "has 52 cards" do
      52.times { deck.draw }
      expect(deck).to be_empty
    end
  end

  describe "#shuffle_cards" do
    it "shuffles the array of cards" do
      new_deck = Deck.new_standard_deck
      card1 = new_deck.draw
      card2 = new_deck.draw
      deck.shuffle_cards
      cards = []
      2.times { cards << deck.draw }
      expect(cards).to_not eq([card1, card2])
    end
  end

  describe "#draw" do
    it "removes a card from the deck and returns it" do
      card = custom_deck.draw
      expect(card).to be(ten_of_clubs)
    end
  end

  describe "#empty?" do
    it "returns true if the deck is empty" do
      expect(empty_deck).to be_empty
    end

    it "returns false if the deck is not empty" do
      expect(custom_deck).to_not be_empty
    end

  end

end
