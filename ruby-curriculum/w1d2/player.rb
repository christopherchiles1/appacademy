require 'io/console'

class Player
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def get_move
    while true
      char = read_char

      case char
      when "\r"
        return board.cursor
      when "\e[A"
        board.move_cursor(:up)
      when "\e[B"
        board.move_cursor(:down)
      when "\e[C"
        board.move_cursor(:right)
      when "\e[D"
        board.move_cursor(:left)
      when "\u0003"
        puts "Exiting..."
        exit 0
      end
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end
end
