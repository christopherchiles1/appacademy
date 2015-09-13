require 'colorize'
require_relative 'card'

class Board
  attr_reader :size, :num_to_match

  def initialize(size, num_to_match)
    @size = size
    @num_to_match = num_to_match
    setup_board
  end

  def flip_card!(position)
    self[position].flip_card!
  end

  def won?
    @grid.flatten.all?(&:revealed?)
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
