# frozen_string_literal: true

require_relative 'cli'

# Player class
class Player
  attr_reader :name, :piece, :cli

  def initialize(piece, player_id)
    @piece = piece
    @cli = CLI.new
    @name = cli.prompt_name(player_id)
  end

  def get_move(board)
    cli.final_move(board, name)
  end

  def handle_win
    cli.display_win_message
  end

  def handle_tie
    cli.display_tie_message
  end

  def ask_replay
    cli.prompt_replay
  end

  def intro_text
    cli.display_intro_text
  end
end
