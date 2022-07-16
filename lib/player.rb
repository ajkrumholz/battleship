require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'


class Player
  attr_reader :cruiser, :submarine
  attr_accessor :board

  def initialize
    @board = Board.new(4, 4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def player_cruiser
    print @board.render(true)
    print "\nEnter the squares for the Cruiser (3 spaces): "
    coordinates = gets.chomp.upcase.split(" ").sort
    print "\n"
    if @board.valid_placement?(@cruiser, coordinates) == true
      @board.place(@cruiser, coordinates)
      else
        print "That strategy is not ideal. Please try again.\n\n"
        player_cruiser
    end
  end

  def player_submarine
    print @board.render(true)
    print "\nEnter the squares for the Submarine (2 spaces): "
    coordinates = gets.chomp.upcase.split(" ").sort
    print "\n"
    if @board.valid_placement?(@submarine, coordinates) == true
      @board.place(@submarine, coordinates)
      else
        print "That strategy is not ideal. Please try again.\n\n"
        player_submarine
    end
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