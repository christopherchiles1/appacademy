require './board'
require './card'
require './player'
require 'byebug'

class Game
  attr_accessor :board, :player, :cursor

  def initialize(size = 4)
    @board = Board.new(size)
    @player = Player.new(board)
  end

  def play
    until over?
      board.render
      selection = player.get_move
      make_guess(selection)
    end
    puts "YOU WON!"
  end

  def make_guess(position)
    @current_guess = position.dup
    if @previous_guess.nil?
      @previous_guess = @current_guess
      @board[@current_guess].reveal
    else
      @board[@current_guess].reveal
      @board.render

      if @board[@current_guess] == @board[@previous_guess]
        handle_match
      else
        handle_no_match
      end
      @previous_guess = nil
    end
  end

  def handle_match
    puts "YOU FOUND A MATCH!"
    sleep(1)
  end

  def handle_no_match
      puts "NO MATCH!"
      sleep(1)
      @board[@previous_guess].hide
      @board[@current_guess].hide
  end

  def over?
    @board.won?
  end
end

if __FILE__ == $PROGRAM_NAME
  # takes size as a command line argument
  size = ARGV.empty? ? 4 : ARGV.shift
  Game.new(size).play
end
