class Card
  attr_accessor :value, :side

  SYMBOLS = ('A'..'Z').to_a

  def initialize(val)
    @value = SYMBOLS[val]
    @side = :down
  end

  def is_hidden?
    side == :down
  end

  def flip_card
    @side = is_hidden? ? :up : :down
  end

  def to_s
    is_hidden? ? " \u2573 " : " #{value} "
  end

  def ==(card)
    self.value == card.value
  end
end
