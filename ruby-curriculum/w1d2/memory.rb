require_relative 'board'
require_relative 'card'
require_relative 'player'

class Game

  def initialize(size = 4)
    @board = Board.new(size)
    @player = Player.new(board)
  end

  def play
    until over?
      board.render
      make_guess(player.get_move)
    end
    puts "YOU WON!"
  end

  private

  attr_reader :board, :player, :first_selection, :current_selection

  def make_guess(position)
    @current_selection = position.dup
    card = board[current_selection]
    raise InvalidSelectionError unless card.is_hidden?

    if first_selection
      other_card = board[first_selection]
      board.show_card_at(current_selection)
      handle_no_match unless card == other_card
      deselect_cards
    else
      @first_selection = current_selection
      board.show_card_at(current_selection)
    end
  end

  def handle_no_match
      sleep(1)
      board[@first_selection].hide
      board[@current_selection].hide
  end

  def deselect_cards
    @first_selection = nil
  end

  def over?
    board.won?
  end
end

class InvalidSelectionError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  # takes size as a command line argument
  size = ARGV.empty? ? 4 : ARGV.shift
  Game.new(size).play
end
