require './board'
require './card'
require './player'
require 'byebug'

class Game
  attr_accessor :board, :player

  def initialize(player, size = 4)
    #@board will be an instance of Board class
    @player = Player.new(player)
    @board = Board.new(size)
    @cursor = [0, 0]
  end

  def play
    until over?
      board.render(@cursor)
      make_guess(show_single_key)
    end
    puts "YOU WON, #{@player.name}!"
  end

  def make_guess(position) #position is an array with 2 numbers
    @current_guess = position.dup
    if @previous_guess.nil?
      @previous_guess = @current_guess
      @board[@current_guess].reveal
    else
      @board[@current_guess].reveal
      @board.render
      # p @current_guess
      # p @previous_guess
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
      sleep(2)
      @board[@previous_guess].hide
      @board[@current_guess].hide
  end

  def over?
    @board.won?
  end

  def show_single_key
    while true
      c = @player.read_char

      case c
      when "\r"
        return @cursor
      when "\e[A" #up arrow
        @cursor[0] = (@cursor[0] - 1) % @board.size
        @board.render(@cursor)
        puts "UP ARROW"
      when "\e[B" #down arrow
        @cursor[0] = (@cursor[0] + 1) % @board.size
        @board.render(@cursor)
        puts "DOWN ARROW"
      when "\e[C" #right arrow
        @cursor[1] = (@cursor[1] + 1) % @board.size
        @board.render(@cursor)
        puts "RIGHT ARROW"
      when "\e[D" #left arrow
        @cursor[1] = (@cursor[1] - 1) % @board.size
        @board.render(@cursor)
        puts "LEFT ARROW"
      when "\u0003"
        puts "CONTROL-C"
        exit 0
      else
      end
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new("Chris", ARGV[0].nil? ? 4 : ARGV[0].to_i)
  game.play
end
