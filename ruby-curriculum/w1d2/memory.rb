require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
  def initialize(difficulty = :easy)
    settings = set_difficulty(difficulty)
    @board = Board.new(*settings)
    @display = Display.new(board)
    @player = Player.new(display)
    @selections = []
  end

  def play
    until over?
      display.render
      make_guess(player.get_move)
    end
    puts "YOU WON!"
  end

  private

  attr_reader :display, :board, :player, :selections

  def set_difficulty(difficulty)
    case difficulty
    when :hard
      [9, 3]
    when :medium
      [8, 2]
    else
      [6, 2]
    end
  end

  def make_guess(position)
    current_selection = position.dup

    @selections << current_selection
    card = board[current_selection]
    raise InvalidSelectionError unless card.hidden?

    board.flip_card!(current_selection)
    display.render

    if selections.length == board.num_to_match
      handle_no_match unless selections.all? { |pos| board[pos] == card }
      deselect_cards
    end
  end

  def handle_no_match
      sleep(0.5)
      selections.each { |pos| board.flip_card!(pos) }
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
  # Allows command line argument for:
  # difficulty: easy, medium, hard
  if ARGV.empty?
    Game.new.play
  else
    difficulty = ARGV.shift.to_sym
    Game.new(difficulty).play
  end
end
