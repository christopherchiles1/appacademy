require 'colorize'

class Board
  attr_reader :size, :cursor

  def initialize(size)
    @size = size
    @cursor = [0, 0]
    setup_board
  end

  def show_card_at(position)
    self[position].reveal
    render
  end

  def render
    system('clear')

    @grid.each_with_index do |line, row|
      line.each_with_index do |card, col|
        if cursor == [row, col]
          print card.to_s.colorize(:light_cyan).on_light_black
        else
          print card
        end
      end

      puts
    end
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

  def won?
    @grid.flatten.all? { |card| card.side == :up }
  end

  def [](position)
    row, col = *position
    @grid[row][col]
  end

  private

  attr_reader :grid

  def setup_board
    cards = create_cards
    @grid = Array.new(size) { Array.new(size) { cards.shift } }
  end

  def create_cards
    cards = []
    num_pairs = (@size ** 2) / 2
    (1..num_pairs).each do |card|
      2.times { cards << Card.new(card) }
    end
    cards.shuffle
  end
end
