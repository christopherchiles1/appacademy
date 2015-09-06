require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :start_node, :move_tree
  attr_accessor :visited_positions

  def initialize(start_position)
    @start_node = PolyTreeNode.new(start_position)
    @visited_positions = [@start_node]
    build_move_tree!
  end

  def self.valid_moves(positon)
    start_row, start_col = positon
    moves = []
    (-2..2).each do |row|
      (-2..2).each do |col|
        next unless (row.abs + col.abs) == 3
        move = [row + start_row, col + start_col]
        moves << PolyTreeNode.new(move) if self.on_board?(move)
      end
    end
    moves
  end

  def self.on_board?(position)
    position.all? { |coord| coord.between?(0, 7) }
    # [0, 1].all? { |idx| (0..7).include?(position[idx]) }
  end

  def new_move_nodes(position)
    new_moves = KnightPathFinder.valid_moves(position).reject do |move|
      visited_positions.include?(move)
    end
    new_moves
  end

  def build_move_tree!
    queue = [start_node]

    until queue.empty?
      current = queue.shift
      new_moves = new_move_nodes(current.value)
      new_moves.each do |move|
        visited_positions << move
        current.add_child(move)
      end
      queue += new_moves
    end
  end

  def find_path(end_position)
    end_node = @start_node.bfs(end_position)
    end_node.trace_path_back.map(&:value).reverse
  end
end
