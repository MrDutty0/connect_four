# frozen_string_literal: true

require_relative '../lib/board'

RSpec.shared_examples 'winning checking' do |testing_method, last_move, board_state, expected_outcome|
  subject(:game_board) { described_class.new }

  before do
    allow(game_board).to receive(:board).and_return(board_state)
  end

  it "returns #{expected_outcome}" do
    state = game_board.send(testing_method, last_move)
    expect(state).to eql(expected_outcome)
  end
end

describe Board do
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

    context 'when won vertically' do
      include_examples 'winning checking', testing_method, [0, 1], [
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'O', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil]
      ], true
    end

    context 'when there are not enough placed symbols' do
      include_examples 'winning checking', testing_method, [3, 1], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil],
        [nil, 'X', nil, nil, nil, nil, nil]
      ], false
    end

    context 'when there is exact amount of pieces vertically' do
      include_examples 'winning checking', testing_method, [2, 0], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil],
        ['O', nil, nil, nil, nil, nil, nil]
      ], true
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
        ['X', 'O', 'X', 'O', 'O', nil, nil]
      ], false
    end

    context 'when piece is placed not at bottom' do
      include_examples 'winning checking', testing_method, [3, 2], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['O', 'X', 'O', 'X', 'X', nil, nil],
        ['X', 'O', 'O', 'X', 'O', 'X', 'O'],
        ['X', 'O', 'X', 'O', 'O', 'O', 'X']
      ], false
    end

    context 'when win happens at not bottom' do
      include_examples 'winning checking', testing_method, [3, 2], [
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil, nil, nil],
        ['O', 'X', 'X', 'X', 'X', nil, nil],
        ['X', 'O', 'O', 'X', 'O', 'X', 'O'],
        ['X', 'O', 'X', 'O', 'O', 'O', 'X']
      ], true
    end
  end
end
