require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/computer'
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
      else
        print "That strategy is not ideal. Please try again.\n"
        self.player_submarine
    end
  end

  def render_boards
    print "\n=============COMPUTER BOARD=============\n"
    print @computer.board.render
    print "=============PLAYER BOARD=============\n"
    print @player.board.render(true)
    print ""
  end

  def player_fire
    print "\nCaptain, we have an open shot!\n"
    shot = gets.chomp.upcase
    @computer.board.cells[shot].fire_upon 
    # verify valid shot
  end
  
  def computer_fire
    shot = @player.board.cells.keys.sample
    @player.board.cells[shot].fire_upon 
    print "\nThey have fired back!\n"

    # need to remove fire_upon cells from array
  end

  def run_game
    menu
    computer.place_submarine
    computer.place_cruiser
    player_cruiser
    player_submarine
    until computer_wins? || player_wins?
      render_boards
      player_fire
      computer_fire
    end
    end_game
  end

  def computer_wins?
    @player.submarine.sunk? && @player.cruiser.sunk?
  end

  def player_wins?
    @computer.submarine.sunk? && @computer.cruiser.sunk?
  end

  def end_game
    if player_wins?
      print "We have ended the Cold War!!"
    else
      print "The Iron Curtian has overcome!"
    end
    exit!
  end
end