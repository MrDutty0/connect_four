# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  let(:first_player) { instance_double(Player, piece: 'X') }
  let(:second_player) { instance_double(Player, piece: 'O') }

  subject(:game) { described_class.new(first_player, second_player) }

  describe '#play_again?' do
    context 'when declining playing again' do
      before do
        allow(first_player).to receive(:ask_replay).and_return('n')
      end

      it 'return false' do
        result = game.play_again?

        expect(result).to be false
      end
    end

    context 'when accepting replay with' do
      accepting_keys = ['y', 'Y']

      before do
        allow(first_player).to receive(:ask_replay).and_return(*accepting_keys)
      end

      accepting_keys.each do |key|
        context "using key #{key.inspect}" do
          it 'returns true' do
            result = game.play_again?
            expect(result).to be true
          end
        end
      end
    end
  end

  describe '#switch_current_player' do
    context 'when switching once' do
      it 'switches to the next player' do
        previous_current_player = game.current_player

        game.switch_current_player
        new_current_player = game.current_player

        expect(new_current_player).not_to eq(previous_current_player)
      end
    end

    context 'when switching twice' do
      it 'returns to the original player' do
        previous_current_player = game.current_player

        game.switch_current_player
        game.switch_current_player
        new_current_player = game.current_player

        expect(new_current_player).to eq(previous_current_player)
      end
    end
  end
end
