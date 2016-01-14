class Player
  attr_reader :name
  attr_accessor :losses

  def initialize(name)
    @name = name
    @losses = 0
  end

  def guess
    print "Pick a letter, #{name}: "
    gets[0].downcase
  end

  def lose
    self.losses = losses + 1
  end

  def score
    "GHOST"[0...losses]
  end
end
