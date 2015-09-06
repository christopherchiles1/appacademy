require './tile'

class Minesweeper

  def initialize(width = 9, height = 9, num_of_bombs = 10)
    @width = width
    @height = height
    @num_of_bombs = num_of_bombs

    @grid = Array.new(height) {Array.new(width)}
    setup_grid
    update_bomb_count
  end

  def make_move(position, move)
    if move.downcase == "f"
      self[position].flag!
    else
      reveal_cell(position)
    end
  end

  def render
    print "   "
    width.times {|col| print " #{col} "}
    print "\n"

    height.times do |row|
      print " #{row} "
      grid[row].each do |tile|
        print tile
      end
      print "\n"
    end
  end

  def won?
    grid.flatten.all? do |tile|
       tile.revealed? || (tile.bomb? && tile.flagged?)
    end
  end

  def lost?
    grid.flatten.any? do |tile|
      tile.bomb? && tile.revealed?
    end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    grid[row][col] = value
  end

  private

  attr_reader :width, :height, :num_of_bombs, :grid

  def setup_grid
    height.times do |row|
      width.times do |col|
        position = [row, col]
        self[position] = Tile.new(position)
      end
    end
    bomb_tiles = grid.flatten.shuffle.first(num_of_bombs)
    bomb_tiles.each { |tile| tile.bomb = true }
  end

  def update_bomb_count
    tiles = grid.flatten
    tiles.each do |tile|
      count_bombs = adjacent_positions(tile.position).count do |position|
        self[position].bomb?
      end
      tile.adjacent_bombs = count_bombs
    end
  end

  def adjacent_positions(position)
    x, y = position
    adjacent_positions = []
    (-1..1).each do |vert|
      (-1..1).each do |horz|
        unless (vert.abs + horz.abs).zero?
          new_position = [x + vert, y + horz]
          adjacent_positions << new_position if include?(new_position)
        end
      end
    end
    adjacent_positions
  end

  def include?(position)
    row, col = position
    row.between?(0, height - 1) && col.between?(0, width - 1)
  end

  def reveal_cell(position)
    current_tile = self[position]

    return position if current_tile.revealed? || current_tile.flagged?
    current_tile.reveal!
    if current_tile.adjacent_bombs > 0
      return position
    else
      adjacent_positions(current_tile.position).each do |position|
        reveal_cell(position) if include?(position)
      end
    end
  end
end
