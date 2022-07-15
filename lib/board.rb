require './lib/cell'
require 'pry'

class Board
  attr_reader :numbers, :letters

  def initialize
    @cells = {"A1" => Cell.new("A1"), "A2" => Cell.new("A2"), "A3" => Cell.new("A3"), "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"), "B2" => Cell.new("B2"), "B3" => Cell.new("B3"), "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"), "C2" => Cell.new("C2"), "C3" => Cell.new("C3"), "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"), "D2" => Cell.new("D2"), "D3" => Cell.new("D3"), "D4" => Cell.new("D4")
    }
    @size_x = 4
    @size_y = 4
    @numbers = (1..@size_x).to_a
    @letters = (1..@size_y).to_a
  end

  def cells
    cell_hash = {}
    coord_arr = @letters.flat_map do |letter|
      letter = (letter + 64).chr
        @numbers.flat_map do |number|
          cell = Cell.new("#{letter}#{number}")
          cell_hash[cell.coordinate] = cell
        end
      end
    cell_hash
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def valid_placement?(ship, placement_coords)
    overlapping = placement_coords.all? do |coordinate| 
      cells[coordinate].ship == nil
    end     
    valid_placement_length?(ship, placement_coords) && consecutive_coords?(placement_coords) && overlapping
  end

  def valid_placement_length?(ship, placement_coords)
    placement_coords.uniq.count == ship.length
  end

  def consecutive_coords?(placement_coords)
    # placement_coords.sort == placement_coords
    letters = []
    numbers = []
    placement_coords.each do |coord|
      letters << coord.split('')[0]
      numbers << coord.split('')[1]
    end
    if letters.uniq.count == 1 && numbers.uniq.count != 1
      numbers.each_cons(2).all? { |a,b| a.to_i == b.to_i - 1 }
    elsif numbers.uniq.count == 1 && letters.uniq.count != 1
      letters.each_cons(2).all? { |a,b| a.ord == b.ord - 1 }
    end
  end

  def place(ship, cell_array)
    cell_array.each do |cell|
      cell.place_ship(ship)
      cells[cell.coordinate] = cell
    end
  end

  def render(state = false)
    letters = []
    numbers = []
    cells.keys.each do |coord|
      letters << coord.split('')[0]
      numbers << coord.split('')[1]
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