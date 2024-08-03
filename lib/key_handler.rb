# frozen_string_literal: true

require_relative 'constants'

# For handling the key press
module KeyHandler
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

  def valid_key?(key)
    Constants::VALID_KEYS.include?(key)
  end

  def enter_key?(key)
    key == Constants::ENTER_KEY
  end
end
