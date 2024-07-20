# frozen_string_literal: true

require_relative '../lib/board'

RSpec.shared_examples 'winning checking' do |last_move, board_state, expected_outcome|
  before do
    allow(game_board).to receive(:board).and_return(board_state)
  end

  it "returns #{expected_outcome}" do
    state = game_board.vertical_win?(last_move)
    expect(state).to eql(expected_outcome)
  end
end

describe Board do
  subject(:game_board) { described_class.new }

  describe '#vertical_win?' do
    context 'when there is no winning vertically' do
      include_examples 'winning checking', [1, 0], [
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil]
      ], false
    end

    context 'when there are not enough placed symbols' do
      include_examples 'winning checking', [3, 1], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil]
      ], false
    end

    context 'when won vertically' do
      include_examples 'winning checking', [0, 1], [
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil]
      ], true
    end
  end
end
