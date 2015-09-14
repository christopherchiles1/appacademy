require 'io/console'

class Player
  def initialize(display)
    @display = display
  end

  def get_selection
    while true
      char = read_char

      case char
      when "\r"
        return display.cursor
      when "\e[A"
        display.move_cursor(:up)
      when "\e[B"
        display.move_cursor(:down)
      when "\e[C"
        display.move_cursor(:right)
      when "\e[D"
        display.move_cursor(:left)
      when "\u0003"
        system("clear")
        display.render_game_over
        exit 0
      end
    end
  end

  private

  attr_reader :display

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
