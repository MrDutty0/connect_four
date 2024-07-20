# frozen_string_literal: true

require_relative 'game_state_checker'
require_relative 'constants'

# Board for connect four
class Board
  include GameStateChecker
  include Constants

  attr_accessor :board

  def initialize
    @board = Array.new(Constants::COLUMN_LENGTH) { Array.new(Constants::ROW_LENGTH) }
  end

  # def determine_game_outcome(last_move)
  # end
end
