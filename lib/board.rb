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

  # def horizontal_win?(last_move)
  # end

  # def diagonal_win?(last_move)
  # end

  private

  def winner_in_row?(row)
    row.compact.size == WINNING_ROW_LENGHT && row.uniq.size == 1
  end
end
