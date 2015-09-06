require 'colorize'

class Board
  attr_reader :size
  def initialize(size)
    @size = size
    @grid = populate
  end

  def populate
    deck = []
    pairs = @size**2 / 2
    (1..pairs).each do |card|
      2.times { deck << Card.new(card) }
    end
    deck.shuffle

    grid = Array.new(size) do |row|
      Array.new(size) do |col|
        deck.shift
      end
    end

    grid
  end

  def render(position=[0,0])
    system('clear')

    @grid.each_with_index do |line, row|
      line.each_with_index do |card, col|
        if position == [row, col]
          print card.to_s.colorize(:light_cyan).on_light_black
        else
          print card
        end
      end

      puts
    end
  end

  def won?
    @grid.flatten.all? { |card| card.side == :up }
  end

  def reveal
  end

  def [](position)
    row, col = *position
    @grid[row][col]
  end

  private

  attr_reader :grid
end
