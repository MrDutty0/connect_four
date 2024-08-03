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
end
