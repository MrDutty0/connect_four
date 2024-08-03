# frozen_string_literal: true

require 'colorize'
require_relative 'constants'

# For printing the board and colorizing the pieces
module BoardDisplay
  def display_board(board, hovered_move)
    colorized_board = colorize_board(board, hovered_move)
    print_board(colorized_board)
  end

  def colorize_board(board, hovered_move)
    board_cp = Marshal.load(Marshal.dump(board))

    board_cp.map.with_index do |row, row_idx|
      row.map.with_index do |piece, col_idx|
        colorize_piece(piece, [row_idx, col_idx], hovered_move)
      end
    end
  end

  def colorize_piece(piece, position, hovered_move)
    color_map = {
      'X' => 'X'.colorize(Constants::YELLOW),
      'O' => 'O'.colorize(Constants::BLUE),
      nil => '-'
    }

    colored_piece = color_map[piece]
    colored_piece = colored_piece.colorize(background: Constants::HOVER_BACKGROUND) if hovered_move == position
    colored_piece
  end

  def print_board(board)
    board.each { |row| puts row.join(' ') }
  end
end
