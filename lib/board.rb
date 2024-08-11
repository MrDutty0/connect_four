# frozen_string_literal: true

require_relative 'game_state_checker'
require_relative 'constants'

# Board for connect four
class Board
  include GameStateChecker
  include Constants

  attr_reader :board

  def initialize
    @board = Array.new(Constants::COLUMN_LENGTH) { Array.new(Constants::ROW_LENGTH) }
  end

  def valid_move?(move)
    row, column = move
    current_piece = board[row][column]

    return false unless current_piece.nil?

    # If on the last row
    return true if row == Constants::COLUMN_LENGTH - 1

    # Not on last row
    below_piece = board[row + 1][column]
    !below_piece.nil?
  end

  def place_piece(move, piece)
    @board[move[0]][move[1]] = piece
  end
end
