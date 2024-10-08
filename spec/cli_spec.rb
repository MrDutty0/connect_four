# frozen_string_literal: true

require_relative '../lib/cli'
require_relative '../lib/constants'

describe CLI do
  subject(:cli) { described_class.new }
  let(:board) { instance_double(Board) }
  let(:player_name) { 'Player 1' }

  describe '#retrieve_move' do
    let(:initial_position) { [Constants::COLUMN_LENGTH / 2, Constants::ROW_LENGTH / 2] }
    let(:error_msg) { 'Invalid pressed key' }

    before do
      allow(cli).to receive(:initial_move_position).and_return(initial_position)
      allow(cli).to receive(:display_move_prompt_text)
      allow(cli).to receive(:display_board)
      allow(cli).to receive(:clear_screen)
    end

    context 'when enter key is pressed' do
      let(:expected_move_outcome) { initial_position }
      context 'after non-valid key' do
        before do
          invalid_key = 'a'
          valid_key = Constants::ENTER_KEY
          allow(cli).to receive(:prompt_for_single_char).and_return(invalid_key, valid_key)
        end

        it 'displays error message once and returns move' do
          expect(cli).to receive(:puts).with(error_msg).once

          result = cli.retrieve_move(board, player_name)
          expect(result).to eq(expected_move_outcome)
        end
      end

      context 'on first press' do
        before do
          valid_key = Constants::ENTER_KEY
          allow(cli).to receive(:prompt_for_single_char).and_return(valid_key)
        end

        it 'returns move after one loop iteration' do
          expect(cli).to receive(:prompt_for_single_char).once

          result = cli.retrieve_move(board, player_name)
          expect(result).to eq(expected_move_outcome)
        end
      end
    end

    context 'when moving key is pressed' do
      let(:expected_move_outcome) { [initial_position[0], initial_position[1] - 1] }
      context 'after non-valid key and then moving and enter keys' do
        before do
          invalid_key = '#'
          valid_keys = [Constants::LEFT_KEY, Constants::ENTER_KEY]
          allow(cli).to receive(:prompt_for_single_char).and_return(invalid_key, *valid_keys)
        end

        it 'displays error, changes position to left and returns move' do
          expect(cli).to receive(:puts).with(error_msg).once

          result = cli.retrieve_move(board, player_name)
          expect(result).to eq(expected_move_outcome)
        end
      end

      context 'directly moving key and then enter key' do
        before do
          valid_keys = [Constants::LEFT_KEY, Constants::ENTER_KEY]
          allow(cli).to receive(:prompt_for_single_char).and_return(*valid_keys)
        end

        it 'changes position to left and returns move' do
          result = cli.retrieve_move(board, player_name)
          expect(result).to eq(expected_move_outcome)
        end
      end
    end
  end

  describe '#final_move' do
    let(:valid_move) { [1, 1] }

    context 'when a valid move is made' do
      before do
        allow(cli).to receive(:retrieve_move).and_return(valid_move)
        allow(board).to receive(:valid_move?).and_return(true)
      end

      it 'returns the valid move' do
        expect(cli).to receive(:retrieve_move).once

        result = cli.final_move(board, player_name)
        expect(result).to eq(valid_move)
      end
    end

    context 'when an invalid move is followed by a valid move' do
      let(:invalid_move) { [2, 2] }
      let(:error_msg) { 'Invalid move' }

      before do
        allow(cli).to receive(:retrieve_move).and_return(invalid_move, valid_move)
        allow(board).to receive(:valid_move?).and_return(false, true)
      end

      it 'error message is displayed and valid move is returned' do
        expect(cli).to receive(:retrieve_move).twice
        expect(cli).to receive(:puts).with(error_msg).once

        result = cli.final_move(board, player_name)
        expect(result).to eq(valid_move)
      end
    end
  end
end
