require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/player'
require './lib/computer'
require 'pry'

class Game
  attr_reader :computer, 
              :player,
              :difficulty
  attr_accessor :columns,
                :rows
  def initialize
    @columns = columns
    @rows = rows
    @computer = Computer.new
    @player = Player.new
    @difficulty = 1
  end

  def print_slow(string)
    string.split(//).each do |character|
      sleep 0.007
      print character
    end
  end

  def print_very_slow(string)
    string.split(//).each do |character|
      sleep 0.04
      print character
    end
  end

  def intro
    print "\n" * 50
    print " " * 18 + "-" * 2 + "\n"
    print " " * 16 + "-" * 6 + "\n"
    print " " * 13 + "-" * 12 + "\n"
    print " " * 10 + "-" * 18 + "\n"
    print " " * 7 + "-" * 24 + "\n"
    print " " * 4 + "-" * 30 + "\n"
    print " " + "-" * 36
    print_very_slow(("\nWelcome to BATTLESHIP, Freedom Fighter\n"))
    print " " + "-" * 36 + "\n"
    print " " * 4 + "-" * 30 + "\n"
    print " " * 7 + "-" * 24 + "\n"
    print " " * 10 + "-" * 18 + "\n"
    print " " * 13 + "-" * 12 + "\n"
    print " " * 16 + "-" * 6 + "\n"
    print " " * 18 + "-" * 2 + "\n"
    print "\n\n"
    run_game
  end

  def menu
    print_very_slow("\nEnter p to play. Enter q to quit. ")
    answer = gets.chomp.downcase
    if answer == 'p'
      menu_setup_options
    elsif answer == 'q'
      exit!
    else
      puts "\nInvalid input, please try again\n"
      menu
    end
  end

  def menu_setup_options
    difficulty_select
    custom_board
    custom_ships
  end


  def difficulty_select
    print "\nPlease select difficulty (1. Easy, 2. Hard): "
    answer = gets.chomp.to_i
    if answer > 0 && answer < 3
      @difficulty = answer
    else
      print "Invalid input, please try again."
      difficulty_select
    end
  end
  
  def custom_board
    custom_columns
    custom_rows
    @player.board = Board.new(@columns, @rows)
    @player.board.build_board
    @computer.board = Board.new(@columns, @rows)
    @computer.board.build_board
  end

  def custom_columns
    print "\nPlease select board width (between 4 and 10 cells): "
    @columns = gets.chomp.to_i
    if @columns < 4 || @columns > 10
      print "Invalid width, please try again."
      custom_columns
    end
  end

  def custom_rows
    print "\nPlease select board height (between 4 and 10 cells): "
    @rows = gets.chomp.to_i
    if @rows < 4 || @rows > 10
      print "\nInvalid height, please try again.\n"
      custom_rows
    end
  end

  def custom_ships
    print "\nIf you so choose, you may dispatch additional craft to the theater.\n"
    custom_ships_menu
  end

  def custom_ships_menu
    print "\nWould you like to add another craft to the fleet? (y/n): "
    answer = gets.chomp
    case answer
    when "y"
      custom_ships_entry
    when "n"
      print_very_slow("\nWelding, riveting, articulating splines...\n")
    else
      print_very_slow("\nInvalid input, please try again\n")
      custom_ships_menu
    end
  end

  def custom_ships_entry
    print "\nEnter a name and length for your craft.\n"
    print "\nName: "
    name = gets.chomp
    print "\nLength (remember, ships must fit on the board): "
    length = gets.chomp.to_i
    custom_ships_validation(name, length)
  end

  def custom_ships_validation(name, length)
    if length < @rows && length < @columns
      @player.ships << Ship.new(name, length)
      @computer.ships << Ship.new(name, length)
      custom_ships_menu
    else
      print_very_slow("\nInvalid length, please try again.")
      custom_ships_entry
    end
  end

  def player_place_ships_dialog
    print_very_slow("\nI have laid out my ships on the grid.\n" +
    "\nYou now need to lay out your #{player.ships.size} ships.\n\n")
  end

  def render_boards(state = false)
    print "\n" * 30
    print "\n=============COMPUTER BOARD=============\n"
    print@computer.board.render(state)
    print "=============PLAYER BOARD=============\n"
    print@player.board.render(true) + "\n"
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
    print "\nEnter a coordinate to fire: "
    shot = gets.chomp.upcase
    print "\n"
    if @computer.board.valid_coordinate?(shot) == true
      if @player_shot_selection.include?(shot) != true
        @computer.board.cells[shot].fire_upon
        @player_shot_selection << shot
        print_very_slow(player_fire_feedback(shot) + "\n")
      else
        print "We've already fired on this coordinate. Choose another.\n"
        player_fire
      end
    else print "\nNo viable firing solution on this location. Try again!\n"
      player_fire
    end      
  end

  def computer_fire_feedback(shot)
    case @player.board.cells[shot].render
    when "M"
      "They've fired back! It's a miss!\n"
    when "H"
      "We're hit. We're taking on water!\n"
    when "X"
      "We've lost the ship!\n"
    end
  end

  def computer_fire_easy
    shot = computer_shot_potentials.shuffle!.shift
    @player.board.cells[shot].fire_upon 
    print_very_slow(computer_fire_feedback(shot) + "\n")
  end
  
  def computer_fire_hard
    if @computer.hunting == false
      shot = computer_shot_potentials.shuffle!.shift
      @player.board.cells[shot].fire_upon 
      print_very_slow(computer_fire_feedback(shot) + "\n")

      if @player.board.cells[shot].render == "H"
        @computer.recent_hit = shot
        @computer.hunting = true
      end

    elsif @computer.hunting == true
      shot = firing_radius
      @player.board.cells[shot].fire_upon
      print_very_slow(computer_fire_feedback(shot) + "\n")
      computer_hunting(shot)
    end
  end

  def computer_hunting(shot)
    case @player.board.cells[shot].render
    when "H"
    @computer.recent_hit = shot
    @computer.hunting = true
    when "X"
    @computer.recent_hit = nil
    @computer.hunting = false
    when "M"
    @computer.recent_hit = nil
    @computer.hunting = false
    end
  end

  def run_game
    menu
    computer_shot_potentials
    @player_shot_selection = []
    @computer.place_ships
    player_place_ships_dialog
    @player.place_ships
    play_game
    end_game
  end
  
  def play_game
    until computer_wins? || player_wins?
      render_boards
      print_very_slow("Captain, we have an open shot!\n")
      player_fire
      end_game if self.player_wins? == true
      @difficulty == 1 ? computer_fire_easy : computer_fire_hard
    end
  end

  def computer_wins?
    @player.ships.all? { |ship| ship.sunk? == true }
  end

  def player_wins?
    @computer.ships.all? { |ship| ship.sunk? == true }
  end

  def end_game
    if player_wins?
      render_boards(true)
      print "We have ended the Cold War!! \n\n\n\n"
    else
      render_boards(true)
      print "The Iron Curtain has overcome! \n\n\n\n"
    end
    game_reset    
  end

  def game_reset
    @player = Player.new
    @computer = Computer.new
    @ships = {cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
    run_game
  end

  def computer_shot_potentials
    shot_potentials = []
    @player.board.cells.each do |key, value|
      if value.fired_upon == false
        shot_potentials << key
      end
    end
    shot_potentials
  end

  def computer_hits
    computer_hits = []
    @player.board.cells.each do |key, value|
      if value.fired_upon == true && value.ship != nil
        computer_hits << key
      end
    end
    computer_hits
  end

  def firing_radius
    shot = @computer.recent_hit
    firing_radius = []
    firing_radius << [(shot.split(//)[0].ord - 1).chr, shot.split(//)[1]].join << [(shot.split(//)[0].ord + 1).chr, shot.split(//)[1]].join << [shot.split(//)[0], (shot.split(//)[1].to_i + 1).to_s].join << [shot.split(//)[0], (shot.split(//)[1].to_i - 1).to_s].join
    firing_radius.reject! { |element| @player.board.valid_coordinate?(element) == false }
    shot = firing_radius.shuffle!.shift
  end
end