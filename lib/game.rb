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

  def intro
    print "\n\n\nWelcome to BATTLESHIP, Freedom Fighter\n\n\n"
    run_game
  end



  def menu
    print "\nEnter p to play. Enter q to quit. "
    answer = gets.chomp.downcase
    if answer == 'p'
      start
    elsif answer == 'q'
      exit!
    else
      puts "\nInvalid input, please try again\n\n"
      self.menu
    end
  end

  def start
    print "\n\nI have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n\n"
  end

  def render_boards
    print "\n=============COMPUTER BOARD=============\n"
    print @computer.board.render
    print "=============PLAYER BOARD=============\n"
    print @player.board.render(true) + "\n"
  end

  def player_fire_feedback(shot)
    case @computer.board.cells[shot].render
    when "M"
      "Negative contact! We can't see them!\n"
    when "H"
      "Contact! We're picking up distress signals!\n"
    when "X"
      "Contact! Target sensors have gone dark! That's a kill.\n"
    end
  end

  def player_fire
    print "\nEnter a coordinate to fire: \n"
    shot = gets.chomp.upcase
    if @computer.board.valid_coordinate?(shot) == true
      @computer.board.cells[shot].fire_upon
    else print "\nNo viable firing solution on this location. Try again!\n"
      player_fire
    end      
    print player_fire_feedback(shot)
  end
  
  def computer_fire
    shot = @computer_shot_selection.shuffle!.shift
    @player.board.cells[shot].fire_upon 
    print "\nThey have fired back!\n"
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
      print "Captain, we have an open shot!\n\n"
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
      print "We have ended the Cold War!! \n\n\n\n"
    else
      print "The Iron Curtain has overcome! \n\n\n\n"
    end
    run_game
  end
end