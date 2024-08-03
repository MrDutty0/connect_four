# frozen_string_literal: true

require_relative '../lib/cli'
require_relative '../lib/constants'

describe KeyHandler do
  let(:cli_dummy) { Class.new { include KeyHandler }.new }

  describe '#enter_key?' do
    context 'recognizes the enter key' do
      it 'return true for enter key' do
        enter_key = "\r"
        result = cli_dummy.enter_key?(enter_key)
        expect(result).to be true
      end
    end

    context 'does not recognize non-enter keys' do
      non_enter_keys = ['e', "\e[D", "\e", '@']

      non_enter_keys.each do |key|
        it "returns false for key: #{key.inspect}" do
          result = cli_dummy.enter_key?(key)
          expect(result).to be false
        end
      end
    end
  end

  describe '#valid_key?' do
    context 'recognizes the valid keys' do
      valid_keys = Constants::VALID_KEYS

      valid_keys.each do |key|
        it "expected true for key: #{key.inspect}" do
          result = cli_dummy.valid_key?(key)
          expect(result).to be true
        end
      end
    end

    context 'does not recognize invalid keys' do
      non_valid_keys = ['e', "\e", '@', '5']

      non_valid_keys.each do |key|
        it "expected false for key: #{key.inspect}" do
          result = cli_dummy.valid_key?(key)
          expect(result).to be false
        end
      end
    end
  end

  describe '#handle_key_press' do
    let(:move) { [1, 1] }

    context 'when pressed key is invalid' do
      let(:invalid_key) { 'e' }

      it 'displays an error message and returns previous move' do
        error_msg = 'Invalid pressed key'

        expect do
          cli_dummy.handle_key_press(invalid_key, move)
        end.to change {
          cli_dummy.instance_variable_get(:@error_msg)
        }.from(nil).to(error_msg)

        result = cli_dummy.handle_key_press(invalid_key, move)
        expect(result).to eq(move)
      end
    end

    context 'when pressed the enter key' do
      let(:enter_key) { Constants::ENTER_KEY }

      it 'returns the move' do
        result = cli_dummy.handle_key_press(enter_key, move)
        expect(result).to eq(move)
      end
    end

    context 'when pressed the left arrow key' do
      let(:valid_key) { Constants::LEFT_KEY }
      let(:updated_move) { [1, 0] }

      before do
        allow(cli_dummy).to receive(:update_move).and_return(updated_move)
      end

      it 'returns the updated move' do
        result = cli_dummy.handle_key_press(valid_key, move)
        expect(result).to eq(updated_move)
      end
    end
  end

  describe '#update_move' do
    shared_examples 'moving' do |initial_move, key, expected_move|
      it "correctly moves when the key is: #{key.inspect}" do
        result = cli_dummy.update_move(initial_move, key)

        expect(result).to eq(expected_move)
      end
    end

    context 'when the move is at the boundaries' do
      context 'wrapping from the top-left corner [0, 0]' do
        initial_move = [0, 0]

        include_examples 'moving', initial_move, Constants::LEFT_KEY, [0, Constants::ROW_LENGTH - 1]
        include_examples 'moving', initial_move, Constants::UP_KEY, [Constants::COLUMN_LENGTH - 1, 0]
      end

      context 'wrapping from the bottom-right corner [COLUMN_LENGTH - 1, ROW_LENGTH - 1]' do
        initial_move = [Constants::COLUMN_LENGTH - 1, Constants::ROW_LENGTH - 1]

        include_examples 'moving', initial_move, Constants::RIGHT_KEY, [Constants::COLUMN_LENGTH - 1, 0]
        include_examples 'moving', initial_move, Constants::DOWN_KEY, [0, Constants::ROW_LENGTH - 1]
      end
    end

    context 'when moving from a non-boundary position' do
      initial_move = [2, 3]

      context 'moving left' do
        include_examples 'moving', initial_move, Constants::LEFT_KEY, [2, 2]
      end

      context 'moving left' do
        include_examples 'moving', initial_move, Constants::UP_KEY, [1, 3]
      end

      context 'moving left' do
        include_examples 'moving', initial_move, Constants::RIGHT_KEY, [2, 4]
      end

      context 'moving left' do
        include_examples 'moving', initial_move, Constants::DOWN_KEY, [3, 3]
      end
    end
  end
end
