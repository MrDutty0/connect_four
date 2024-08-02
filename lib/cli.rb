# frozen_string_literal: true

require 'colorize'
require_relative 'constants'

# Class to handle all CLI interactions
class CLI
  attr_reader :curr_error_msg, :last_move

  def initialize
    @error_msg = nil

    prev_row = Constants::COLUMN_LENGTH / 2
    prev_col = Constants::ROW_LENGTH / 2

    @last_move = [prev_row, prev_col]
  end

  def display_board(board)
    colorized_board = colorize_board(board)
    print_board(colorized_board)
  end

  def prompt_name(player_id)
    puts "Player #{player_id}"
    puts 'Enter your name:'

    name = gets.chomp

    clear_screen
    name
  end

  def colorize_board(board)
    board_cp = Marshal.load(Marshal.dump(board))

    board_cp.map.with_index do |row, row_idx|
      row.map.with_index do |piece, col_idx|
        colorize_piece(piece, row_idx, col_idx)
      end
    end
  end

  def colorize_piece(piece, row_idx, col_idx)
    color_map = {
      'X' => 'X'.colorize(Constants::YELLOW),
      'O' => 'O'.colorize(Constants::BLUE),
      nil => '-'
    }

    colored_piece = color_map[piece]

    if last_move == [row_idx, col_idx]
      colored_piece = colored_piece.colorize(background: Constants::HOVER_BACKGROUND).underline
    end

    colored_piece
  end

  def print_board(board)
    board.each do |row|
      row.each do |piece|
        print "#{piece} "
      end
      puts
    end
  end

  def move_prompt_text
    clear_screen
    puts "#{name}, it's your turn!"
    puts 'Use arrow keys to move, press enter to submit'
  end

  def clear_screen
    puts "\e[2J"
  end
end
