require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    children = TicTacToeNode.new(game.board, mark).children
    if winning_child = children.find { |child| child.winning_node?(mark) }
      winning_child.prev_move_pos
    else
      children.find { |child| !child.losing_node?(mark) }.prev_move_pos
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
