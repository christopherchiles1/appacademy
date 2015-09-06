
require './player'
require './minesweeper'
require 'yaml'
require 'colorize'

class Game

  def initialize(player)
    @player = player
    @minesweeper = Minesweeper.new
  end

  def self.load_game(file)
    YAML.load(File.read(file)).play
  end

  def play
    minesweeper.render
    until over?
      input = player.prompt
      save_game if input == 'save'
      minesweeper.make_move(*input)
      minesweeper.render
    end
    puts "Game over"
  end

private

  attr_reader :player, :minesweeper

  def save_game
    print "Save game as: "
    file_name = gets.chomp
    serialized_game = self.to_yaml
    File.open(file_name, 'w') {|f| f.write(serialized_game)}
    Kernel.abort("Game Saved")
  end

  def over?
    minesweeper.won? || minesweeper.lost?
  end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    player =  Player.new("Justin")
    game = Game.new(player)
    game.play
  else
    Game.load_game(ARGV.shift)
  end
end
