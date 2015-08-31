require_relative "player.rb"

class Game
  def initialize(player1, player2)
    @current_player, @previous_player = [player1, player2].shuffle
    @fragment = ""
    @full_dictionary = {}
    File.foreach("./ghost-dictionary.txt") do |line|
      @full_dictionary[line.chomp] = true
    end
    @dictionary = @full_dictionary
    @losses = Hash.new { |hash, key| hash[key] = 0 }
  end

  def play
    until game_over?
      play_round
      display_leaderboard
      reset_game
    end
    puts "Game Over"
    display_leaderboard
  end

  private

  attr_accessor :fragment, :dictionary, :losses
  attr_reader :current_player, :previous_player

  def play_round
    until round_over?
      display_fragment
      take_turn(current_player)
      next_player!
    end
    puts "You lost the round, #{previous_player.name}"
    losses[previous_player] += 1
  end

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

  def game_over?
    losses.values.include?(5)
  end

  def display_leaderboard
    losses.each do |person, losses|
      puts "#{person.name}: #{loss_string(losses)}"
    end
  end

  def loss_string(losses)
    "GHOST"[1..losses]
  end

  def reset_game
    @fragment = ""
    @dictionary = @full_dictionary
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("player1")
  p2 = Player.new("player2")
  Game.new(p1, p2).play
end
