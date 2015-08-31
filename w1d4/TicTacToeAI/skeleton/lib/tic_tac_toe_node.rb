require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return (board.winner != evaluator && !board.winner.nil?)  if board.over?
    if evaluator == next_mover_mark # Player's turn
      children.all? { |child| child.losing_node?(evaluator) }
    else # Other player's turn
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?
    if evaluator == next_mover_mark # Player's turn
      children.any? { |child| child.winning_node?(evaluator) }
    else # Other player's turn
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |col|
        position = [row, col]
        next unless board.empty?(position)
        new_board = board.dup
        new_board[position] = next_mover_mark
        mark = (next_mover_mark == :x ? :o : :x)

        children << TicTacToeNode.new(new_board, mark, position)
      end
    end
    children
  end
end
