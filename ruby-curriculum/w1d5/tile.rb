class Tile
  attr_reader :position
  attr_accessor :bomb, :flagged, :revealed, :adjacent_bombs

  def initialize(position)
    @position = position
    @adjacent_bombs = 0
    @flagged = false
    @bomb = false
    @revealed = false
  end

  alias_method :bomb?, :bomb
  alias_method :revealed?, :revealed
  alias_method :flagged?, :flagged

  def to_s
    return " F " if flagged
    if revealed
      return " B " if bomb?
      return " #{adjacent_bombs} " if adjacent_bombs > 0
      return "   "
    else
      " * "
    end
  end

  def flag!
    self.flagged = !flagged unless revealed
  end

  def reveal!
    self.revealed = true unless revealed
  end

end
