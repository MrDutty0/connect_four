# frozen_string_literal: true

require_relative '../lib/board'
require_relative 'board_scenarios'

# Use a more descriptive name for the method that stubs the board state
def stub_board_state(board, board_state)
  allow(board).to receive(:board).and_return(board_state)
end

describe Board do
  subject(:board) { described_class.new }

  context '#valid_move?' do
    context 'when the move is on the last row' do
      let(:board_state) { board_with_partially_filled_last_row }

      before do
        stub_board_state(board, board_state)
      end

      context 'when the position is empty' do
        it 'returns true' do
          position = [Constants::COLUMN_LENGTH - 1, 1]
          result = board.valid_move?(position)

          expect(result).to be true
        end
      end

      context 'when the position has a piece' do
        it 'returns false' do
          position = [Constants::COLUMN_LENGTH - 1, 2]
          result = board.valid_move?(position)

          expect(result).to be false
        end
      end
    end

    context 'when the move is not on the last row' do
      let(:board_state) { board_with_mixed_pieces }

      before do
        stub_board_state(board, board_state)
      end

      context 'when there is not a piece directly below' do
        it 'returns false' do
          position = [Constants::COLUMN_LENGTH - 2, 2]
          result = board.valid_move?(position)

          expect(result).to be false
        end
      end

      context 'when there is a piece directly below' do
        it 'returns false when the position has a piece' do
          position = [Constants::COLUMN_LENGTH - 2, 1]
          result = board.valid_move?(position)

          expect(result).to be false
        end

        it 'returns true when the position is empty' do
          position = [Constants::COLUMN_LENGTH - 2, 0]
          result = board.valid_move?(position)

          expect(result).to be true
        end
      end
    end
  end

  describe '#place_piece' do
    context 'when placing a piece on an empty place' do
      let(:piece) { 'X' }
      let(:move) { [5, 0] }

      it 'places the piece at the specified location' do
        board.place_piece(move, piece)

        expect(board.board[move[0]][move[1]]).to eq(piece)
      end
    end

    context 'when placing a piece on an occupied place' do
      let(:piece) { 'X' }
      let(:move) { [5, 0] }

      before do
        board.place_piece(move, 'O')
      end

      it 'overwrites the existing piece' do
        board.place_piece(move, piece)
        expect(board.board[move[0]][move[1]]).to eq(piece)
      end
    end
  end
end
