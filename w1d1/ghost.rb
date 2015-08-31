class Game
  attr_accessor :fragment, :current_player, :previous_player, :dictionary

  def initialize(player1, player2)
    @fragment = ""
    @current_player = player1
    @previous_player = player2
    @dictionary = {}
    File.foreach("./ghost-dictionary.txt") do |line|
      @dictionary[line.chomp] = true
    end
  end

  def play_round
    until @dictionary.empty? || (@dictionary.length == 1 && @dictionary.keys[0] == @fragment)
      take_turn(@current_player)
      next_player!
    end
    puts "You lost, #{current_player.name}"
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def take_turn(player)
    input = player.guess
    until valid_play?(input)
      player.alert_invalid_guess
      input = player.guess
    end
    @fragment += input
    @dictionary = filter_dictionary
    puts "There are still #{dictionary.length} valid words"
  end

  def valid_play?(guess)
    guess.length == 1 && !filter_dictionary(guess).empty?
  end

  def filter_dictionary(guess = "")
    @dictionary.select { |k, v| k.include?(@fragment + guess) }
  end
end

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

if __FILE__ == $PROGRAM_NAME
  Game.new(Player.new("Player1"), Player.new("Player2")).play_round
end
