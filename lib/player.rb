require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'


class Player
  attr_reader :cruiser, :submarine
  attr_accessor :board

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end


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