# frozen_string_literal: true

require 'board'

class Game
  def initialize(*players)
    @players = players
    @current_player = players.first

    @board = Board.new
  end
end