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

  def retrieve_move(board)
    cli.final_move(board, name)
  end
end
