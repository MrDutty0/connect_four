# frozen_string_literal: true

require_relative '../lib/board'

RSpec.shared_examples 'winning checking' do |testing_method, last_move, board_state, expected_outcome|
  subject(:game_board) { described_class.new }

  before do
    allow(game_board).to receive(:board).and_return(board_state)
  end

  it "returns #{expected_outcome}" do
    state = case testing_method
            when :full_board? then game_board.send(testing_method)
            else game_board.send(testing_method, last_move)
            end
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

  describe '#diagonal_win?' do
    testing_method = :diagonal_win?

    context 'When same type pieces are going right from left' do
      context 'when the same type 4th piece is the top leftmost' do
        include_examples 'winning checking', testing_method, [2, 0], [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', 'X', nil, nil, nil, nil, nil],
          ['O', 'O', 'X', nil, nil, nil, nil],
          ['X', 'O', 'O', 'X', 'O', 'O', nil]
        ], true
      end

      context 'when 4th piece is between same type pieces' do
        include_examples 'winning checking', testing_method, [3, 1], [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', 'X', nil, nil, nil, nil, nil],
          ['O', 'O', 'X', nil, nil, nil, nil],
          ['X', 'O', 'O', 'X', 'O', 'O', nil]
        ], true
      end

      context 'when the same type 4th piece is the bottom rightmost' do
        include_examples 'winning checking', testing_method, [5, 3], [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', 'X', nil, nil, nil, nil, nil],
          ['O', 'O', 'X', nil, nil, nil, nil],
          ['X', 'O', 'O', 'X', 'O', 'O', nil]
        ], true
      end

      context 'when there are not enough same type pieces' do
        include_examples 'winning checking', testing_method, [3, 1], [
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          ['X', nil, nil, nil, nil, nil, nil],
          ['X', 'X', nil, nil, nil, nil, nil],
          ['O', 'O', 'X', nil, nil, nil, nil],
          ['X', 'O', 'O', 'O', 'O', 'O', nil]
        ], false
      end
    end

    context 'When same type pieces are going left from right' do
      context 'when the same type 4th piece is the top rightmost' do
        include_examples 'winning checking', testing_method, [0, 6], [
          [nil, nil, nil, nil, nil, nil, 'O'],
          [nil, nil, nil, nil, nil, 'O', 'X'],
          [nil, nil, nil, nil, 'O', 'O', 'X'],
          [nil, nil, nil, 'O', 'X', 'X', 'O'],
          [nil, nil, 'X', 'X', 'O', 'O', 'O'],
          [nil, nil, 'O', 'X', 'O', 'O', 'O']
        ], true
      end

      context 'when 4th piece is between same type pieces' do
        include_examples 'winning checking', testing_method, [2, 4], [
          [nil, nil, nil, nil, nil, nil, 'O'],
          [nil, nil, nil, nil, nil, 'O', 'X'],
          [nil, nil, nil, nil, 'O', 'O', 'X'],
          [nil, nil, nil, 'O', 'X', 'X', 'O'],
          [nil, nil, 'X', 'X', 'O', 'O', 'O'],
          [nil, nil, 'O', 'X', 'O', 'O', 'O']
        ], true
      end

      context 'when the same type 4th piece is the bottom leftmost' do
        include_examples 'winning checking', testing_method, [3, 3], [
          [nil, nil, nil, nil, nil, nil, 'O'],
          [nil, nil, nil, nil, nil, 'O', 'X'],
          [nil, nil, nil, nil, 'O', 'O', 'X'],
          [nil, nil, nil, 'O', 'X', 'X', 'O'],
          [nil, nil, 'X', 'X', 'O', 'O', 'O'],
          [nil, nil, 'O', 'X', 'O', 'O', 'O']
        ], true
      end

      context 'when there are not enough same type pieces' do
        include_examples 'winning checking', testing_method, [2, 4], [
          [nil, nil, nil, nil, nil, nil, 'X'],
          [nil, nil, nil, nil, nil, 'O', 'X'],
          [nil, nil, nil, nil, 'O', 'O', 'X'],
          [nil, nil, nil, 'O', 'X', 'X', 'O'],
          [nil, nil, 'X', 'X', 'O', 'O', 'O'],
          [nil, nil, 'O', 'X', 'O', 'O', 'O']
        ], false
      end

      context 'when the same type pieces are not consecutive' do
        include_examples 'winning checking', testing_method, [3, 3], [
          [nil, nil, nil, nil, nil, nil, 'O'],
          [nil, nil, nil, nil, nil, 'O', 'X'],
          [nil, nil, nil, nil, 'X', 'O', 'X'],
          [nil, nil, nil, 'O', 'X', 'X', 'O'],
          [nil, nil, 'O', 'X', 'O', 'O', 'O'],
          [nil, 'X', 'O', 'X', 'O', 'O', 'O']
        ], false
      end
    end
  end

  describe '#full_board?' do
    testing_method = :full_board?

    context 'when board is full of pieces' do
      include_examples 'winning checking', testing_method, [0, 0], [
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O'],
        ['X', 'X', 'O', 'X', 'O', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'O', 'O'],
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O']
      ], true
    end

    context 'when board is not full of pieces' do
      include_examples 'winning checking', testing_method, [0, 0], [
        ['X', nil, 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O'],
        ['X', 'X', 'O', 'X', 'O', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'O', 'O'],
        ['X', 'O', 'X', 'O', 'X', 'O', 'X'],
        ['O', 'X', 'O', 'X', 'O', 'X', 'O']
      ], false
    end
  end
end
