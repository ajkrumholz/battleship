require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'


class Player
  attr_reader :board, 

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
    # @ships = [@cruiser, @sub]
  end

  def ship_place(ship)
    coordinates = []

    until @board.valid_placement?(ship,coordinates)
      coordinates = []
      # ship.length.times do
      #   coordinates << @board.cells.keys.sample
      #   coordinates.sort!
      

    # @ships.each do |ship|
    #   print "Enter the squares for the #{ship.name} (#{ship.length} spaces): "
    #   coordinates = gets.chomp.split(" ")
    #   if @board.valid_placement?(ship,coordinates) == true
    #     @board.place_cruiser(ship, coordinates)
      # else
  
    end
  end

  def place_cruiser
    coordinates = ship_place(@cruiser)
    @board.place(@cruiser, coordinates)
  end



end