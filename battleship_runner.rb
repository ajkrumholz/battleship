require './lib/game'
require './lib/ship'
require 'ruby2d'

menu_theme = Sound.new('menu_theme.mp3')
menu_theme.play
game = Game.new
game.intro
game.menu
