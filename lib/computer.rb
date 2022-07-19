require './lib/game'
require './lib/ship'
require './lib/board'
require 'pry'

class Computer
  attr_accessor :board,
                :hunting,
                :recent_hit,
                :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new('Cruiser', 3), Ship.new('Submarine', 2)]
    @hunting = false
    @recent_hit = nil
  end

  def ship_placer(ship)
    coordinates = []
    until @board.valid_placement?(ship, coordinates)
      coordinates = []
      ship.length.times do
        coordinates << @board.cells.keys.sample
        coordinates.sort!
      end
    end
    coordinates
  end

  def place_ships
    @ships.each do |ship|
      coordinates = ship_placer(ship)
      @board.place(ship, coordinates)
    end
  end
end
