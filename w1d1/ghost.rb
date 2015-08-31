require_relative "player.rb"

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
      display_fragment
      take_turn(current_player)
      next_player!
    end
    puts "You lost the round, #{previous_player.name}"
  end

  private

  attr_accessor :fragment, :dictionary
  attr_reader :current_player, :previous_player

  def round_over?
    word_spelled?
  end

  def word_spelled?
    dictionary.include?(fragment)
  end

  def display_fragment
    puts "Fragment: #{fragment}"
  end

  def take_turn(player)
    input = player.guess
    until valid_play?(input)
      input = player.alert_invalid_guess
    end
    @fragment += input
    filter_dictionary!
  end

  def next_player!
    @current_player, @previous_player = @previous_player, @current_player
  end

  def valid_play?(char)
    ('a'..'z').include?(char) && valid_char?(char)
  end

  def valid_char?(char)
    dictionary.any? { |k, _| k.start_with?(@fragment + char)}
  end

  def filter_dictionary!
    self.dictionary = dictionary.select { |k, _| k.start_with?(@fragment) }
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("player1")
  p2 = Player.new("player2")
  Game.new(p1, p2).play_round
end
