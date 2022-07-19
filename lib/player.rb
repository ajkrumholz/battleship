require './lib/game'
require './lib/ship'
require './lib/computer'
require 'pry'

class Player
  attr_accessor :board,
                :ships

  def initialize
    @board = Board.new
    @ships = [Ship.new('Cruiser', 3), Ship.new('Submarine', 2)]
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
        coordinates = gets.chomp.upcase.split(' ').sort
        if @board.valid_placement?(ship, coordinates) == false
          print_very_slow("\nThat strategy is not ideal. Please try again.\n\n")
          sleep 0.3
          print "\n" * 20
          print @board.render(true) + "\n"
        end
      end
      @board.place(ship, coordinates)
      print "\n" * 20 + @board.render(true)
    end
  end
end
