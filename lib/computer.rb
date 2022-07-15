# require './lib/board'
# require './lib/cell'
# require './lib/ship'
require './lib/game'
require 'pry'

class Computer
  attr_reader :board

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
  end

  def comp_ship_place
    # computer pickes a random number of ship.length as "first letter" or "second number" for starting cell for ship 1 'cruiser'
    # computer pickes next cells randomply as directly right or down
    # if right add ship.length to start cell
    # if down
    # place_cruiser method and place_sub method. scale on refactor
    # validate coordinates true => next ship, false => reiterate
  end

end
