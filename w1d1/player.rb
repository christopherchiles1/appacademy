class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "#{name}, pick a letter."
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess, try again."
  end
end
