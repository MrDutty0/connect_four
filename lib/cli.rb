# frozen_string_literal: true

require 'io/console'
require_relative 'constants'
require_relative 'key_handler'
require_relative 'board_display'
require_relative 'io_handler'

# Class to handle all CLI interactions
class CLI
  include KeyHandler
  include BoardDisplay
  include IOHandler

  attr_reader :curr_error_msg, :move

  def initialize
    @error_msg = nil
  end

  def final_move(board, player_name)
    loop do
      display_error_msg
      move = retrieve_move(board, player_name)

      # return move if board.valid_move?(move)

      @error_msg = 'Invalid move'
    end
  end

  private

  def initial_move_position
    [Constants::COLUMN_LENGTH / 2, Constants::ROW_LENGTH / 2]
  end

  def retrieve_move(board, player_name)
    move = initial_move_position

    loop do
      display_error_msg
      display_move_prompt_text(player_name)
      display_board(board, move)

      key = prompt_for_single_char
      clear_screen

      move = handle_key_press(key, move)
      return move if enter_key?(key)
    end
  end
end
