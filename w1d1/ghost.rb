require_relative "player.rb"

class Game
  def initialize(players = [Player.new("player1"), Player.new("player2")])
    @players = players.shuffle
    @losses = setup_leaderboard
    @dictionary = setup_dictionary("./ghost-dictionary.txt")
  end

  def play
    until game_over?
      setup_round
      play_round
      display_leaderboard
      wait_for_enter
    end
    end_game_text
  end

  private

  attr_accessor :fragment, :remaining_words, :losses
  attr_reader :current_player, :players, :dictionary

  def game_over?
    players.select { |player| valid_player?(player)}.one?
  end

  def winner
    players.select { |player| valid_player?(player)}.first
  end

  def setup_round
    @remaining_words = @dictionary
    @fragment = ""
    puts "Starting new round!"
  end

  def play_round
    until round_over?
      until valid_player?(players.first) && players.first != current_player
        players.rotate!
      end
      system('clear')
      display_fragment
      @current_player = players.first
      take_turn(current_player)
    end
    losses[current_player] += 1
  end

  def round_over?
    word_spelled?
  end

  def word_spelled?
    remaining_words.include?(fragment)
  end

  def display_fragment
    puts "Fragment: #{fragment.capitalize}"
  end

  def take_turn(player)
    input = get_move(player)
    @fragment += input
    filter_remaining_words!
  end

  def get_move(player)
    input = player.guess
    valid_play?(input) # have valid_play return error
    input
  rescue ArgumentError => e
    puts e.message
    retry
  end

  def valid_play?(char)
    unless ('a'..'z').include?(char) && valid_char?(char)
      raise ArgumentError.new("Invalid character")
    end
  end

  def valid_char?(char)
    remaining_words.any? { |k, _| k.start_with?(@fragment + char)}
  end

  def filter_remaining_words!
    self.remaining_words = remaining_words.select { |k, _| k.start_with?(@fragment) }
  end

  def valid_player?(player)
    losses[player] < 5
  end

  def display_leaderboard
    system('clear')
    puts "Leaderboard: "
    puts "-----------------"
    losses.each do |person, losses|
      puts "#{person.name}: #{loss_string(losses)}"
    end
    puts "-----------------"
  end

  def wait_for_enter
    puts "Press enter to continue..."
    gets # used to pause until enter is pressed
  end

  def end_game_text
    display_leaderboard
    puts "#{winner.name} won the game!"
  end

  def loss_string(losses)
    "GHOST"[0...losses]
  end

  def setup_leaderboard
    losses = {}
    players.each { |player| losses[player] = 0 }
    losses
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
