require './lib/board'
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

  def intro
    print "\n" * 50
    print ' ' * 18 + '-' * 2 + "\n"
    print ' ' * 16 + '-' * 6 + "\n"
    print ' ' * 13 + '-' * 12 + "\n"
    print ' ' * 10 + '-' * 18 + "\n"
    print ' ' * 7 + '-' * 24 + "\n"
    print ' ' * 4 + '-' * 30 + "\n"
    print ' ' + '-' * 36
    print_very_slow(("\nWelcome to BATTLESHIP, Freedom Fighter\n"))
    sleep 0.5
    print ' ' + '-' * 36 + "\n"
    print ' ' * 4 + '-' * 30 + "\n"
    print ' ' * 7 + '-' * 24 + "\n"
    print ' ' * 10 + '-' * 18 + "\n"
    print ' ' * 13 + '-' * 12 + "\n"
    print ' ' * 16 + '-' * 6 + "\n"
    print ' ' * 18 + '-' * 2 + "\n"
    print "\n\n"
    run_game
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
    print "\n\n\nPlease select difficulty (1. Easy, 2. Hard): "
    answer = gets.chomp.to_i
    if answer > 0 && answer < 3
      @difficulty = answer
    else
      print 'Invalid input, please try again.'
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
    print 'Please select board width (between 4 and 10 cells): '
    @columns = gets.chomp.to_i
    if @columns < 4 || @columns > 10
      print 'Invalid width, please try again.'
      custom_columns
    end
  end

  def custom_rows
    print 'Please select board height (between 4 and 10 cells): '
    @rows = gets.chomp.to_i
    if @rows < 4 || @rows > 10
      print 'Invalid height, please try again.'
      custom_rows
    end
  end

  def custom_ships
    print "\nIf you so choose, you may dispatch additional craft to the theater.\n"
    custom_ships_menu
  end

  def custom_ships_menu
    print 'Would you like to add another craft to the fleet? (y/n): '
    answer = gets.chomp
    custom_ships_menu_options(answer)
  end

  def custom_ships_menu_options(answer)
    case answer
    when 'y'
      custom_ships_entry
    when 'n'
      comical_ellipses
    else
      print_very_slow('Invalid input, please try again')
      custom_ships_menu
    end
  end

  def custom_ships_entry
    print "\nEnter a name and length for your craft."
    print "\nName: "
    name = gets.chomp
    print 'Length (remember, ships must fit on the board): '
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

  def comical_ellipses
    print_very_slow("\n" * 4 + "\nWelding.....\n\n\n\n\n       Riveting.....\n\n\n\n\n  Reticulating splines...", 0.05)
    print_very_slow('............', 0.08)
    print_very_slow("... . . . . . . .\n\n\n\n\n", 0.1)
  end

  def player_place_ships_dialog
    print_very_slow("\nI have carefully placed my mighty warships on the grid." +
    "\nNow you need to lay out your, *impolite cough*, \"boats.\"\n\n")
    sleep 0.2
  end

  def render_boards(state = false)
    print "\n" * 30
    print "\n=============COMPUTER BOARD=============\n"
    print @computer.board.render(state)
    print "=============PLAYER BOARD=============\n"
    print @player.board.render(true) + "\n"
  end

  def play_game
    until computer_wins? || player_wins?
      render_boards
      print "\nCaptain, we have an open shot!\n"
      player_fire
      end_game if player_wins? == true
      @difficulty == 1 ? computer_fire_easy : computer_fire_hard
    end
  end

  def player_fire
    print "\nEnter a coordinate to fire: "
    shot = gets.chomp.upcase
    if @computer.board.valid_coordinate?(shot) == true
      if @player_shot_selection.include?(shot) != true
        @computer.board.cells[shot].fire_upon
        @player_shot_selection << shot
        player_fire_feedback(shot)
      else
        print_very_slow("\nWe've already fired on this coordinate. Choose another.\n")
        player_fire
      end
    else
      print_very_slow("\nNo viable firing solution on this location. Try again!\n")
      player_fire
    end
  end

  def player_fire_feedback(shot)
    case @computer.board.cells[shot].render
    when 'M'
      print_very_slow("\nNegative contact! We can't see them!\n")
      sleep 0.5
    when 'H'
      print_very_slow("\nContact! We're picking up distress signals!\n")
      sleep 0.5
    when 'X'
      print_very_slow("\nContact! Target sensors have gone dark! Enemy boat sunk.\n")
      sleep 0.5
    end
  end

  def computer_fire_easy
    shot = computer_shot_potentials.shuffle!.shift
    @player.board.cells[shot].fire_upon
    computer_fire_feedback(shot)
  end

  def computer_fire_hard
    if @computer.hunting == false
      shot = computer_shot_potentials.shuffle!.shift
      computer_not_hunting_behavior(shot)
      computer_hits_reaction(shot) if @player.board.cells[shot].render == 'H'
    elsif @computer.hunting == true
      computer_hunting_behavior
    end
  end

  def computer_shot_potentials
    shot_potentials = []
    @player.board.cells.each do |key, value|
      shot_potentials << key if value.fired_upon == false
    end
    shot_potentials
  end

  def computer_hits
    computer_hits = []
    @player.board.cells.each do |key, value|
      computer_hits << key if value.fired_upon == true && !value.ship.nil?
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

  def computer_hits_reaction(shot)
    @computer.recent_hit = shot
    @computer.hunting = true
    print_very_slow("\nNow I'm hunting you.....\n", 0.08)
    sleep 1
  end

  def computer_not_hunting_behavior(shot)
    @player.board.cells[shot].fire_upon
    computer_fire_feedback(shot)
  end

  def computer_hunting_behavior
    shot = firing_radius
    @player.board.cells[shot].fire_upon
    computer_fire_feedback(shot)
    computer_hunting(shot)
  end

  def computer_hunting(shot)
    case @player.board.cells[shot].render
    when 'H'
      begin_the_hunt(shot)
    when 'X'
      not_hunting
      print_very_slow("\nI've got you now!\n", 0.08)
      sleep 0.5
    when 'M'
      not_hunting
      print_very_slow("\nNo! Where did you go?!\n", 0.08)
      sleep 0.5
    end
  end

  def begin_the_hunt(shot)
    print_very_slow("\nI can see you.....\n", 0.08)
    sleep 0.5
    @computer.recent_hit = shot
    @computer.hunting = true
  end

  def not_hunting
    @computer.recent_hit = nil
    @computer.hunting = false
  end

  def computer_fire_feedback(shot)
    case @player.board.cells[shot].render
    when 'M'
      print_very_slow("\nThey've fired back! It's a miss!\n")
      sleep 0.5
    when 'H'
      print_very_slow("\nWe're hit. We're taking on water!\n")
      sleep 0.5
    when 'X'
      print_very_slow("\nWe're hit again! We've lost the ship!\n")
      sleep 0.5
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
      print_very_slow("VICTORY! WE HAVE ENDED THE COLDEST WAR!!\n", 0.1)
      sleep 2
    else
      render_boards(true)
      print_very_slow("DEFEAT! THE IRON CURTAIN WILL NEVER LIFT!!\n", 0.1)
      sleep 2
    end
    game_reset
  end

  def game_reset
    @player = Player.new
    @computer = Computer.new
    @ships = { cruiser: Ship.new('Cruiser', 3), submarine: Ship.new('Submarine', 2) }
    run_game
  end

  def print_very_slow(string, time = 0.04)
    string.split(//).each do |character|
      sleep time
      print character
    end
  end
end
