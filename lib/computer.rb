require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

class Computer
  
  attr_accessor :board,
                :cruiser, 
                :submarine,
                :hunting,
                :recent_hit

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @hunting = false
    @recent_hit = nil
  end

  def ship_place(ship)
    coordinates = []
    until @board.valid_placement?(ship,coordinates)
      coordinates = []
      ship.length.times do
        coordinates << @board.cells.keys.sample
        coordinates.sort!
      end
    end
    return coordinates
  end

  def place_cruiser
    coordinates = ship_place(@cruiser)
    @board.place(@cruiser, coordinates)
  end

  def place_submarine
    coordinates = ship_place(@submarine)
    @board.place(@submarine, coordinates)
  end

end
