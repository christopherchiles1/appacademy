require_relative "player.rb"

class Game
  def initialize(players = [Player.new("Nick"), Player.new("Lisa")])
    @dictionary = setup_dictionary("./ghost-dictionary.txt")
    @players = players.shuffle
    @current = 0
    @round = 0
  end

  def play
    game_intro
    until game_over?
      setup_round
      play_round
      display_leaderboard
    end
    game_outro
  end

  private

  attr_accessor :round, :fragment, :remaining_words, :round_over, :current
  attr_reader :dictionary, :players

  def game_intro
    system('clear')
    puts "Welcome to Ghost"
  end

  def setup_round
    self.round = round + 1
    self.fragment = ""
    self.remaining_words = dictionary
    puts "--- Round #{round} ---"
  end

  def play_round
    until word_spelled? || invalid_fragment?
      change_player
      take_turn(current_player)
      system('clear')
    end
    puts "--- Round #{round} over ---"
    puts "'#{fragment.capitalize}' is a complete word" if word_spelled?
    puts "No words begin with '#{fragment.capitalize}'" if invalid_fragment?
    current_player.lose
  end

  def word_spelled?
    remaining_words.include?(fragment)
  end

  def invalid_fragment?
    remaining_words.empty?
  end

  def take_turn(player)
    puts "Current fragment: #{fragment.capitalize}" unless fragment.empty?
    input = player.guess
    self.fragment = fragment + input
    filter_remaining_words!
  end

  def valid_play?(char)
    remaining_words.any? { |k, _| k.start_with?(fragment + char)}
  end

  def current_player
    players[current]
  end

  def change_player
    loop do
      self.current = (current + 1) % players.length
      break if valid_player?(current_player)
    end
  end

  def game_over?
    players.select { |player| valid_player?(player) }.one?
  end

  def winner
    players.select { |player| valid_player?(player) }.first
  end

  def filter_remaining_words!
    self.remaining_words = remaining_words.select do |k, _|
      k.start_with?(fragment)
    end
  end

  def valid_player?(player)
    player.losses < 5
  end

  def display_leaderboard
    puts "\n-----------------"
    players.each do |player|
      puts "#{player.name}:   #{player.score}"
    end
    puts "-----------------\n\n"
  end

  def game_outro
    puts "#{winner.name} won the game!"
  end

  def setup_dictionary(file_name)
    dictionary = {}
    File.foreach(file_name) { |line| dictionary[line.chomp] = true }
    dictionary
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
