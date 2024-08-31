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

    winner_in_row?(row, 0)
  end

  def horizontal_win?(last_move)
    i, j = last_move
    winner_in_row?(board[i], j)
  end

  def winner_in_row?(row, idx)
    current_piece = row[idx]
    piece_occurrences = 1

    # Check left
    (idx - 1).downto(0) { |left| row[left] == current_piece ? piece_occurrences += 1 : break }

    # Check right
    (idx + 1).upto(row.size - 1) { |right| row[right] == current_piece ? piece_occurrences += 1 : break }

    piece_occurrences >= Constants::WINNING_ROW_LENGTH
  end

  def diagonal_win?(last_move)
    diagonals = [[1, 1], [1, -1]]

    diagonals.any? do |row_step, col_step|
      total_pieces =
        count_continuous_pieces(last_move, row_step, col_step) +
        count_continuous_pieces(last_move, -row_step, -col_step) + 1
      total_pieces >= Constants::WINNING_ROW_LENGTH
    end
  end

  def count_continuous_pieces(start_position, row_step, col_step)
    piece_to_match = board[start_position[0]][start_position[1]]

    current_row = start_position[0] + row_step
    current_col = start_position[1] + col_step

    matching_pieces_count = 0

    while in_bounds?(current_row, current_col) && board[current_row][current_col] == piece_to_match
      matching_pieces_count += 1
      current_row += row_step
      current_col += col_step
    end

    matching_pieces_count
  end

  def full_board?
    board.each do |row|
      return false if row.any?(&:nil?)
    end
    true
  end

  def game_over?(last_move)
    vertical_win?(last_move) || horizontal_win?(last_move) || diagonal_win?(last_move) || full_board?
  end

  def in_bounds?(row, col)
    row.between?(0, Constants::COLUMN_LENGTH - 1) && col.between?(0, Constants::ROW_LENGTH - 1)
  end
end
