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
    row, col = last_move

    diagonals = extract_diagonals(row, col)
    diagonals.any? do |diagonal|
      winner_in_row?(diagonal, col)
    end
  end

  def full_board?
    board.each do |row|
      return false if row.any?(&:nil?)
    end
    true
  end

  private

  def extract_diagonals(row, col)
    [
      extract_diagonal(row, col, 1, 1).reverse + [board[row][col]] + extract_diagonal(row, col, -1, -1),
      extract_diagonal(row, col, 1, -1).reverse + [board[row][col]] + extract_diagonal(row, col, -1, 1)
    ]
  end

  def extract_diagonal(row, col, row_inc, col_inc)
    diagonal = []

    while in_bounds?(row += row_inc, col += col_inc)
      diagonal << board[row][col]
    end

    diagonal
  end

  def in_bounds?(row, col)
    row.between?(0, Constants::COLUMN_LENGTH - 1) && col.between?(0, Constants::ROW_LENGTH - 1)
  end
end
