require_relative 'board'
require_relative 'player'

class Game
  def initialize(size = 4, num_to_match = 2)
    @board = Board.new(size, num_to_match)
    @player = Player.new(board)
    @selections = []
  end

  def play
    until over?
      board.render
      make_guess(player.get_move)
    end
    puts "YOU WON!"
  end

  private

  attr_reader :board, :player, :selections

  def make_guess(position)
    current_selection = position.dup

    @selections << current_selection
    card = board[current_selection]
    raise InvalidSelectionError unless card.is_hidden?

    board.show_card_at(current_selection)

    if selections.length == board.num_to_match
      handle_no_match unless selections.all? { |pos| board[pos] == card }
      deselect_cards
    end
  end

  def handle_no_match
      sleep(0.5)
      selections.each { |pos| board[pos].flip_card }
  end

  def deselect_cards
    @selections = []
  end

  def over?
    board.won?
  end
end

class InvalidSelectionError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  # takes size and num_to_match as command line arguments
  size = ARGV.empty? ? 4 : ARGV.shift.to_i
  num_to_match = ARGV.empty? ? 2 : ARGV.shift.to_i
  Game.new(size, num_to_match).play
end
