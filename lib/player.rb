# frozen_string_literal: true

require 'colorize'
require_relative 'constants'

# Player class
class Player
  attr_reader :name, :piece

  def initialize(name, piece)
    @name = name
    @piece = piece

    clear_screen
  end

  def self.create_player(piece, player_id)
    name = prompt_name(player_id)

    Player.new(name, piece)
  end

  def display_board(board, last_move)
    colorized_board = colorize_board(board, last_move)
    print_board(colorized_board)
  end

  private_class_method def self.prompt_name(player_id)
    puts "Player #{player_id}"
    puts 'Enter your name:'
    gets.chomp
  end

  private

  def colorize_board(board, last_move)
    board_cp = Marshal.load(Marshal.dump(board))

    board_cp.map.with_index do |row, row_idx|
      row.map.with_index do |piece, col_idx|
        colorize_piece(piece, last_move, row_idx, col_idx)
      end
    end
  end

  def colorize_piece(piece, last_move, row_idx, col_idx)
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
