# frozen_string_literal: true

def board_with_partially_filled_last_row
  [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, 'O', nil],
    [nil, nil, nil, nil, nil, 'X', nil],
    [nil, nil, nil, 'O', nil, 'X', nil],
    [nil, nil, 'X', 'O', nil, 'X', 'O']
  ]
end

def board_with_mixed_pieces
  [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, 'O', nil, 'X', 'X', nil, nil],
    ['X', 'O', nil, 'O', 'O', nil, 'O']
  ]
end
