# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  let(:player1) { instance_double(Player, piece: 'X') }
  let(:player2) { instance_double(Player, piece: 'O') }

  subject(:game) { described_class.new(player1, player2) }

  describe '#play_again?' do
    context 'when declining playing again' do
      before do
        allow(player1).to receive(:ask_replay).and_return('n')
      end

      it 'return false' do
        result = game.play_again?

        expect(result).to be false
      end
    end

    context 'when accepting replay with' do
      accepting_keys = ['y', 'Y']

      before do
        allow(player1).to receive(:ask_replay).and_return(*accepting_keys)
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

  describe '#play_match' do
    let(:board) { instance_double(Board) }

    before do
      allow(player1).to receive(:intro_text)
      allow(game).to receive(:board).and_return(board)
    end

    context 'when the game continues for two iterations before a win' do
      before do
        allow(board).to receive(:game_over?).and_return(false, false, true)
        allow(board).to receive(:full_board?).and_return(false)
      end

      it 'runs the loop and exits after first player wins' do
        expect(player1).to receive(:intro_text).once

        expect(player1).to receive(:get_move).with(board).twice
        expect(player2).to receive(:get_move).with(board).once

        expect(board).to receive(:place_piece).exactly(3).times
        expect(board).to receive(:game_over?).exactly(3).times

        expect(game.current_player).to receive(:handle_win)

        game.play_match
      end
    end

    %i[handle_tie handle_win].each do |testing_method|
      context 'when the game ends in first iteration' do
        before do
          ending_as_tie = testing_method == :handle_tie

          allow(board).to receive(:game_over?).and_return(true)
          allow(board).to receive(:full_board?).and_return(ending_as_tie)
        end

        it "calls #{testing_method} on the current player when the game is over" do
          expect(player1).to receive(:get_move).with(board).once

          expect(board).to receive(:place_piece).once
          expect(board).to receive(:game_over?).once

          expect(player1).to receive(testing_method)
          game.play_match
        end
      end
    end
  end
end
