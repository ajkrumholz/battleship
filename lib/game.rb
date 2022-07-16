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
    shot = @computer_shot_selection.shuffle!.shift
    @player.board.cells[shot].fire_upon 
require 'pry'; binding.pry
    print "\nThey have fired back!\n"

    # need to remove fire_upon cells from array
  end

  def intro
    print "Welcome to BATTLESHIP, Freedom Fighter\n"
    run_game
  end

  def run_game
    menu
    @computer_shot_selection = @player.board.cells.keys
    @computer.place_submarine
    @computer.place_cruiser
    @player.player_cruiser
    @player.player_submarine
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
      print "We have ended the Cold War!! "
    else
      print "The Iron Curtain has overcome!"
    end
    run_game
  end
end