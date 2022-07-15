require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Game
  attr_reader :board, :ship, :cell

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
  end

  def menu
    print "Welcome to BATTLESHIP, Freedom Fighter\n"
    print "Enter p to play. Enter q to quit. "
    answer = gets.chomp.downcase
    if answer == 'p'
      start #move into play game/place ship
    elsif answer == 'q'
      # exit runner
    else
      # give error and rerun "Enter p to play. Enter q to quit. "
    end
  end

  def start
    # computer places ships
    print "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long."
    # render board for user to input ship 1
  end

end