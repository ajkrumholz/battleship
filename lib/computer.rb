require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

class Computer
  
  attr_accessor :board,                
                :hunting,
                :recent_hit,
                :ships

  def initialize
    @board = Board.new
    @ships = {}
    @hunting = false
    @recent_hit = nil
  end

  def ship_placer(ship)
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

  def place_ships
    @ships.each do |key, ship|
      coordinates = ship_placer(ship)
      @board.place(ship, coordinates)
    end
  end

  # def place_submarine
  #   coordinates = ship_place(@submarine)
  #   @board.place(@submarine, coordinates)
  # end

end
