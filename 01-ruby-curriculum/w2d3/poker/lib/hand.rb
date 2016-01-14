class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def to_s
    cards.map { |card| card.to_s }.join(", ")
  end
end
