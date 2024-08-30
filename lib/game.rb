# frozen_string_literal: true

require 'board'

# Managing game logic
class Game
  attr_reader :current_player, :board

  def initialize(*players)
    @players = players
    @current_player = players.first

    @board = Board.new
  end

  def play_match
    current_player.intro_text

    loop do
      move = current_player.get_move(board)
      board.place_piece(move, current_player.piece)

      if board.game_over?(move)
        return current_player.handle_tie if board.full_board?

        return current_player.handle_win
      end

      switch_current_player
    end
  end

  def play_again?
    answer = current_player.ask_replay

    answer.downcase.start_with?('y')
  end

  def switch_current_player
    @current_player = (@players - [current_player]).first
  end

  def set_up_new_game
    @board = Board.new
  end
end
