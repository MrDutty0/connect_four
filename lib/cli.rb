# frozen_string_literal: true

require 'io/console'
require 'colorize'
require_relative 'constants'

# Class to handle all CLI interactions
class CLI
  attr_reader :curr_error_msg, :move

  def initialize
    @error_msg = nil
  end

  def final_move(board)
    loop do
      display_error_msg
      move = retrieve_move(board)

      # return move if board.valid_move?(move)

      @error_msg = 'Invalid move'
    end
  end

  def prompt_name(player_id)
    puts "Player #{player_id}"
    puts 'Enter your name:'

    name = gets.chomp

    clear_screen
    name
  end

  private

  def display_error_msg
    puts @error_msg unless @error_msg.nil?
    @error_msg = nil
  end

  def initial_move_position
    [Constants::COLUMN_LENGTH / 2, Constants::ROW_LENGTH / 2]
  end

  def retrieve_move(board)
    move = initial_move_position

    loop do
      display_error_msg
      display_board(board, move)
      display_move_prompt_text

      key = prompt_for_single_char
      clear_screen

      move = handle_key_press(key, move)
      return move if enter_key?(key)
    end
  end

  def handle_key_press(key, move)
    if valid_key?(key)
      enter_key?(key) ? move : update_move(move, key)
    else
      @error_msg = 'Invalid pressed key'
      move
    end
  end

  def update_move(move, key)
    row, col = move

    row_offset, col_offset = key_operations[key]

    [
      (row + row_offset + Constants::COLUMN_LENGTH) % Constants::COLUMN_LENGTH,
      (col + col_offset + Constants::ROW_LENGTH) % Constants::ROW_LENGTH
    ]
  end

  def key_operations
    {
      Constants::UP_KEY => [-1, 0],
      Constants::DOWN_KEY => [1, 0],
      Constants::RIGHT_KEY => [0, 1],
      Constants::LEFT_KEY => [0, -1]
    }
  end

  def prompt_for_single_char
    input = $stdin.getch
    begin
      input += $stdin.read_nonblock(2)
    rescue IO::WaitReadable
      nil
    end
    input
  end

  def valid_key?(key)
    Constants::VALID_KEYS.include?(key)
  end

  def enter_key?(key)
    key == Constants::ENTER_KEY
  end

  def display_move_prompt_text
    puts 'Use arrow keys to move, press enter to submit'
  end

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

  def clear_screen
    puts "\e[2J"
  end
end
