#!/usr/bin/env ruby

require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
  LEVELS = {
    hard: [9, 3],
    medium: [8, 2],
    easy: [6, 2]
  }

  def initialize(difficulty = :easy)
    settings = LEVELS[difficulty] || LEVELS[:easy]
    @board = Board.new(*settings)
    @display = Display.new(board)
    @player = Player.new(display)
    @num_rounds = 0
  end

  def play
    display.render
    until over?
      play_round
    end
    display.render_game_won(num_rounds)
  end

  private

  attr_reader :display, :board, :player, :selections, :num_rounds

  def play_round
    until board.done_selecting?
      begin
        select_card(player.get_selection)
      rescue InvalidSelectionError
        retry
      end
    end
    handle_selections
    board.deselect_cards
    display.render
    @num_rounds += 1
  end

  def handle_selections
    handle_no_match unless board.match?
  end

  def handle_no_match
      sleep(0.5)
      board.selections.each { |pos| board.flip_card!(pos) }
  end

  def select_card(position)
    current_cursor = position.dup
    raise InvalidSelectionError if board[current_cursor].revealed?
    board.selections << current_cursor
    board.flip_card!(current_cursor)
    display.render
  end

  def over?
    board.won?
  end
end

class InvalidSelectionError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  # set difficulty in command line: easy, medium, hard
  if ARGV.empty?
    Game.new.play
  else
    difficulty = ARGV.shift.to_sym
    Game.new(difficulty).play
  end
end
