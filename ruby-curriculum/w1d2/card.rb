class Card

  SYMBOLS = ('A'..'Z').to_a
  attr_reader :value

  def initialize(val)
    @value = SYMBOLS[val]
    @side = :down
  end

  def hidden?
    side == :down
  end

  def revealed?
    side == :up
  end

  def flip_card!
    @side = hidden? ? :up : :down
  end

  def to_s
    hidden? ? " \u2716 " : " #{value} "
  end

  def ==(other_card)
    self.value == other_card.value
  end

  private

  attr_reader :side
end
