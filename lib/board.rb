require './lib/cell'
require 'pry'

class Board
  attr_reader :numbers, 
              :letters 
  attr_accessor :cells,
                :columns,
                :rows

  def initialize(columns = 4, rows = 4)
    @columns = columns
    @rows = rows
    @numbers = (1..columns).to_a
    @letters = (1..rows).to_a
    @cells = {}
  end

  def build_board
    @letters.flat_map do |letter|
      letter = (letter + 64).chr
      @numbers.flat_map do |number|
        cell = Cell.new("#{letter}#{number}")
        @cells[cell.coordinate] = cell
      end
    end
  end
  
  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end 

  def place(ship, cell_array)
    cell_array.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end
  
  def valid_placement?(ship, coordinates)
    valid_placement_length?(ship, coordinates) && consecutive_coordinates?(coordinates) && overlapping?(coordinates) && not_diagonal(coordinates)
  end

  def valid_placement_length?(ship, coordinates)
    coordinates.uniq.count == ship.length
  end

  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coordinate| coordinate.split('')[0] }
    numbers = coordinates.flat_map { |coordinate| coordinate.split('', 2)[1] }

    if letters.uniq.count == coordinates.count
      letters.each_cons(2).all? { |a,b| a.ord == b.ord - 1 }
    elsif numbers.uniq.count == coordinates.count
      numbers.each_cons(2).all? { |a,b| a.to_i == b.to_i - 1 }
    end
  end

  def overlapping?(coordinates)
    coordinates.all? do |coordinate|
      valid_coordinate?(coordinate) && @cells[coordinate].ship == nil
    end
  end

  def not_diagonal(coordinates)
    letters = coordinates.map { |coordinate| coordinate.split('')[0] }
    numbers = coordinates.flat_map { |coordinate| coordinate.split('', 2)[1] }

    if letters.uniq.count == 1 && numbers.uniq.count == coordinates.count
      true
    elsif numbers.uniq.count == 1 && letters.uniq.count == coordinates.count
      true
    else
      false
    end
  end
  
  def render(state = false)
    letters = []
    numbers = []
    @cells.keys.each do |coord|
      letters << coord.split('')[0]
      numbers << coord.split('',2)[1]
    end
    header = "  #{numbers.uniq.join(' ')} \n"
    board_display = []
    letters.uniq.each do |letter|
      board_display << "#{letter} "
      cells.values.each do |cell|
        if cell.coordinate[0] == letter
          if state == false
          board_display << "#{cell.render} "
          elsif state == true
          board_display << "#{cell.render(true)} "
          end
        end
      end
      board_display << "\n"   
    end
    header + board_display.join
  end
end