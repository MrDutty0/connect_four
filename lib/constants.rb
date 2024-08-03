# frozen_string_literal: true

# Constants for the game
module Constants
  ROW_LENGTH = 7
  COLUMN_LENGTH = 6
  WINNING_ROW_LENGTH = 4

  YELLOW = :light_yellow
  BLUE = :blue
  HOVER_BACKGROUND = :light_black

  ENTER_KEY = "\r"
  UP_KEY = "\e[A"
  DOWN_KEY = "\e[B"
  RIGHT_KEY = "\e[C"
  LEFT_KEY = "\e[D"

  VALID_KEYS = [UP_KEY, DOWN_KEY, RIGHT_KEY, LEFT_KEY, ENTER_KEY].freeze
end
