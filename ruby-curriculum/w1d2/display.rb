class Display
  attr_reader :cursor

  def initialize(board, color_options = {})
    @board = board
    @size = board.size
    @cursor = [0, 0]
    @color_options = color_options.merge(color_defaults)
  end

  def render
    system('clear')
    render_title
    render_border_top
    size.times do |row|
      render_border_left
      render_line(row)
      render_border_right
    end
    render_border_bottom
  end

  def render_game_won(num_rounds)
    color = color_options[:title]
    puts "You won in #{num_rounds} guesses!".send(color)
  end

  def move_cursor(dir)
    case dir
    when :up
      cursor[0] = (cursor[0] - 1) % size
    when :down
      cursor[0] = (cursor[0] + 1) % size
    when :right
      cursor[1] = (cursor[1] + 1) % size
    when :left
      cursor[1] = (cursor[1] - 1) % size
    end
    render
  end

  def render_game_over
    color = color_options[:border]
    render_title
    puts ("\u2550" * 15).send(color)
    puts "   GAME OVER   ".send(color_options[:title])
    puts ("\u2550" * 15).send(color)
  end

  private

  attr_reader :color_options, :board, :size

  def color_defaults
    {
      title: :blue,
      border: :yellow,
      card_back: :blue,
      card_face: :red,
      cursor: :green,
      selection: :yellow
    }
  end

  def render_title
    color = color_options[:title]
    print " Memory -- ".send(color)
    print "Match #{board.num_to_match} -- ".send(color)
    puts "#{board.size} x #{board.size} ".send(color)
  end

  def render_border_top
    color = color_options[:border]
    print "  \u2554\u2550".send(color)
    size.times { print "\u2550\u2550\u2550".send(color) }
    print "\u2550\u2557 ".send(color)
    puts
  end

  def render_border_bottom
    color = color_options[:border]
    print "  \u255A\u2550".send(color)
    size.times { print "\u2550\u2550\u2550".send(color) }
    print "\u2550\u255D ".send(color)
    puts
  end

  def render_border_left
    color = color_options[:border]
    print "  \u2551 ".send(color)
  end

  def render_border_right
    color = color_options[:border]
    print " \u2551 ".send(color)
    puts
  end

  def render_line(row)
    size.times do |col|
      position = [row, col]
      card = board[position]
      if cursor == position
        render_cursor(card)
      elsif board.selections.include?(position)
        render_selection(card)
      else
        render_card(card)
      end
    end
  end

  def render_cursor(card)
    color = color_options[(card.hidden? ? :card_back : :card_face)]
    print card.to_s.send(color).colorize(background: color_options[:cursor])
  end

  def render_selection(card)
    color = color_options[(card.hidden? ? :card_back : :card_face)]
    print card.to_s.send(color).colorize(background: color_options[:selection])
  end

  def render_card(card)
    print card.hidden? ? card.to_s.blue : card.to_s.red
  end
end
