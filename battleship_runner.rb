require_relative 'lib/board'
require_relative 'lib/cell'
require_relative 'lib/ship'
require_relative 'lib/game'
require_relative 'lib/computer'
require_relative 'lib/player'
require 'pry'

game = Game.new
# computer = Computer.new


# game.menu

# game.computer.place_submarine
# game.computer.place_cruiser

game.player_cruiser
game.player_submarine