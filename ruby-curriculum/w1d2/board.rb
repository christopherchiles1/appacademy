require 'colorize'
require_relative 'card'

class Board
  attr_reader :size, :cursor, :num_to_match

  def initialize(size, num_to_match = 2)
    @size = size
    @num_to_match = num_to_match
    @cursor = [0, 0]
    setup_board
  end

  def show_card_at(position)
    self[position].flip_card
    render
  end

  def render
    system('clear')
    print "  \u2554\u2550".yellow
    size.times { print "\u2550\u2550\u2550".yellow }
    print "\u2550\u2557 ".yellow
    puts
    @grid.each_with_index do |line, row|
      print "  \u2551 ".yellow
      line.each_with_index do |card, col|
        if cursor == [row, col]
          print card.is_hidden? ? card.to_s.blue.on_green : card.to_s.red.on_green
        else
          print card.is_hidden? ? card.to_s.blue : card.to_s.red
        end
      end
      print " \u2551 ".yellow
      puts
    end
    print "  \u255A\u2550".yellow
    size.times { print "\u2550\u2550\u2550".yellow }
    print "\u2550\u255D ".yellow
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
    num_matches = (@size ** 2) / num_to_match
    (0...num_matches).each do |card|
      num_to_match.times { cards << Card.new(card % 26) }
    end
    cards.shuffle
  end
end
