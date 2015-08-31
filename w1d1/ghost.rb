require "./player.rb"

class Game
  def initialize(player1, player2)
    @current_player, @previous_player = [player1, player2].shuffle
    @fragment = ""
    @dictionary = {}
    File.foreach("./ghost-dictionary.txt") do |line|
      @dictionary[line.chomp] = true
    end
  end

  def play_round
    until round_over?
      take_turn(@current_player)
      next_player!
    end
    puts "You lost the round, #{previous_player.name}"
  end

  private

  attr_accessor :fragment, :dictionary
  attr_reader :current_player, :previous_player

  def round_over?
    @dictionary.empty? || (@dictionary.length == 1 && @dictionary.keys[0] == @fragment)
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

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def valid_play?(guess)
    guess.length == 1 && !filter_dictionary(guess).empty?
  end

  def filter_dictionary(guess = "")
    @dictionary.select { |k, v| k.include?(@fragment + guess) }
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("player1")
  p2 = Player.new("player2")
  Game.new(p1, p2).play_round
end
