require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'


class Player
  attr_accessor :board,
                :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    # @ships = game.ships
  end

  def print_very_slow(string, time = 0.04)
    string.split(//).each do |character|
      sleep time
      print character
    end
  end

  def place_ships
    print @board.render(true)
    @ships.each do |ship|
      coordinates = []
      until @board.valid_placement?(ship, coordinates) == true
        print "\nEnter the squares for the #{ship.name} (#{ship.length} spaces): "
        coordinates = gets.chomp.upcase.split(" ").sort
        if @board.valid_placement?(ship, coordinates) == false
          print "\nThat strategy is not ideal. Please try again.\n"
          print @board.render(true) + "\n"
        end
      end
      @board.place(ship, coordinates)
      print "\n" + @board.render(true)
    end
  end

  # def player_cruiser
  #   print @board.render(true)
  #   print "\nEnter the squares for the Cruiser (3 spaces): "
  #   coordinates = gets.chomp.upcase.split(" ").sort
  #   print "\n"
  #   if @board.valid_placement?(@cruiser, coordinates) == true
  #     @board.place(@cruiser, coordinates)
  #     else
  #       print "That strategy is not ideal. Please try again.\n\n"
  #       player_cruiser
  #   end
  # end

  # def player_submarine
  #   print @board.render(true)
  #   print "\nEnter the squares for the Submarine (2 spaces): "
  #   coordinates = gets.chomp.upcase.split(" ").sort
  #   print "\n"
  #   if @board.valid_placement?(@submarine, coordinates) == true
  #     @board.place(@submarine, coordinates)
  #     else
  #       print "That strategy is not ideal. Please try again.\n\n"
  #       player_submarine
  #   end
  # end
end