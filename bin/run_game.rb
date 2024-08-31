# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

player1 = Player.new('X', 1)
player2 = Player.new('O', 2)

game = Game.new(player1, player2)

game.play_game