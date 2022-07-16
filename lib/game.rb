require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require 'pry'

class Game
  attr_reader :computer, :player

  def initialize
    @computer = Computer.new
    @player = Player.new
  end

  def menu
    print "Welcome to BATTLESHIP, Freedom Fighter\n"
    print "Enter p to play. Enter q to quit. "
    answer = gets.chomp.downcase
    if answer == 'p'
      start #move into play game/place ship
    elsif answer == 'q'
      exit!
    else
      puts "Invalid input, please try again"
      self.menu# give error and rerun "Enter p to play. Enter q to quit. "
    end
  end

  def start
    # computer places ships
    print "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n"
    # render board for user to input ship 1
  end

  def player_cruiser
    print @player.board.render(true)
    print "Enter the squares for the Cruiser (3 spaces): "
    coordinates = gets.chomp.upcase.split(" ").sort
    if @player.board.valid_placement?(@player.cruiser, coordinates) == true
      @player.board.place(@player.cruiser, coordinates)
      else
        print "That strategy is not ideal. Please try again.\n"
        self.player_cruiser
    end
  end

  def player_submarine
    print @player.board.render(true)
    print "Enter the squares for the Submarine (2 spaces): "
    coordinates = gets.chomp.upcase.split(" ").sort
    if @player.board.valid_placement?(@player.submarine, coordinates) == true
      @player.board.place(@player.submarine, coordinates)
      print @player.board.render(true)
      else
        print "That strategy is not ideal. Please try again.\n"
        self.player_submarine
    end
  end
end