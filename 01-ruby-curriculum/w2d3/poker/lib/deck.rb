require_relative 'card'

class Deck
  def self.new_standard_deck
    suits = [:spades, :hearts, :diamonds, :clubs]
    cards = []
    suits.each do |suit|
      (2..14).each do |value|
        cards << Card.new(value, suit)
      end
    end
    Deck.new(cards)
  end

  def initialize(cards)
    @cards = cards
  end

  def shuffle_cards
    cards.shuffle!
  end

  def draw
    cards.pop
  end

  def empty?
    cards.empty?
  end

  private
  attr_reader :cards
end
