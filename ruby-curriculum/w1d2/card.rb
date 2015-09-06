class Card
  attr_accessor :value, :side

  def initialize(val)
    @value = val
    @side = :down
  end

  def hide
    @side = :down
  end

  def reveal
    @side = :up
  end

  def to_s
    if self.side == :down
      "X"
    else
      "#{value}"
    end
  end

  def ==(card)
    self.value == card.value
  end
end
