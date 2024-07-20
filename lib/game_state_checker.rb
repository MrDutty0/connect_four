# frozen_string_literal: true

require_relative 'board'
require_relative 'constants'

# Module to check the game state
module GameStateChecker
  def vertical_win?(last_move)
    i, j = last_move
    return false if Constants::COLUMN_LENGTH - i < Constants::WINNING_ROW_LENGTH

    end_idx = i + Constants::WINNING_ROW_LENGTH

    row = []
    (i...end_idx).each { |culumn_idx| row << board[culumn_idx][j] }

    winner_in_row?(row)
  end

  def horizontal_win?(last_move)
    i, j = last_move
    current_piece = board[i][j]

    piece_occurrences = 1

    # Check left
    (j - 1).downto(0) do |left|
      break if board[i][left] != current_piece

      piece_occurrences += 1
    end

    # Check right
    (j + 1).upto(Constants::ROW_LENGTH - 1) do |right|
      break if board[i][right] != current_piece

      piece_occurrences += 1
    end

    piece_occurrences >= Constants::WINNING_ROW_LENGTH
  end

  private

  def winner_in_row?(row)
    row.compact.size == (Constants::WINNING_ROW_LENGTH) && row.uniq.size == 1
  end
end
