# frozen_string_literal: true

ROW_LENGHT = 7
COLUMN_LENGHT = 6
WINNING_ROW_LENGHT = 4

# Board for connect four
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  # def determine_game_outcome(last_move)
  # end

  # def player_won?(last_move)
  # end

  def vertical_win?(last_move)
    i, j = last_move
    return false if COLUMN_LENGHT - i < WINNING_ROW_LENGHT

    end_idx = i + WINNING_ROW_LENGHT

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
    (j + 1).upto(ROW_LENGHT - 1) do |right|
      break if board[i][right] != current_piece

      piece_occurrences += 1
    end

    piece_occurrences >= WINNING_ROW_LENGHT
  end

  # def diagonal_win?(last_move)
  # end

  private

  def winner_in_row?(row)
    row.compact.size == WINNING_ROW_LENGHT && row.uniq.size == 1
  end
end

