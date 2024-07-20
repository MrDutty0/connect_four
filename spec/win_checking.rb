# frozen_string_literal: true

require_relative '../lib/board'

RSpec.shared_examples 'winning checking' do |testing_method, last_move, board_state, expected_outcome|
  before do
    allow(game_board).to receive(:board).and_return(board_state)
  end

  it "returns #{expected_outcome}" do
    state = game_board.send(testing_method, last_move)
    expect(state).to eql(expected_outcome)
  end
end

describe Board do
  subject(:game_board) { described_class.new }

  describe '#vertical_win?' do
    testing_method = :vertical_win?

    context 'when there is no winning vertically' do
      include_examples 'winning checking', testing_method, [1, 0], [
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil],
        ['X', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil]
      ], false
    end

    context 'when there are not enough placed symbols' do
      include_examples 'winning checking', testing_method, [3, 1], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil]
      ], false
    end
  end

  describe '#horizontal_win?' do
    testing_method = :horizontal_win?

    context 'when piece is the left most 4th of the same type' do
      include_examples 'winning checking', testing_method, [5, 1], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', 'O', 'O', 'O', 'O', nil, nil]
      ], true
    end

    context 'when piece is the right most 4th of the same type' do
      include_examples 'winning checking', testing_method, [5, 4], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', 'O', 'O', 'O', 'O', nil, nil]
      ], true
    end

    context 'when piece is between the same type of pieces' do
      include_examples 'winning checking', testing_method, [5, 2], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', 'O', 'O', 'O', 'O', nil, nil]
      ], true
    end

    context 'when last placed piece is between the same type pieces' do
      include_examples 'winning checking', testing_method, [5, 2], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['X', 'O', 'O', 'O', 'O', nil, nil]
      ], true
    end
  end
end
