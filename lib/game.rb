# frozen_string_literal: true

require 'board'

# Managing game logic
class Game
  def initialize(*players)
    @players = players
    @current_player = players.first

    @board = Board.new
  end

  def play_again?
    answer = current_player.ask_replay

    answer.downcase.start_with?('y')
  end
end
