require './lib/cell'
require 'pry'

class Board
  attr_reader :numbers, :letters

  def initialize
    # @cells = {}
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
    return cell_hash
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
  end

  def valid_placement?(ship, placement_coords)
    overlapping = placement_coords.any? do |coordinate| 
      cells[coordinate].ship != nil
    end
    valid_placement_length?(ship, placement_coords) && consecutive_coords?(placement_coords) && overlapping
  end

  def valid_placement_length?(ship, placement_coords)
    placement_coords.uniq.count == ship.length
  end

  def consecutive_coords?(placement_coords)
    placement_coords.sort == placement_coords
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

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      coordinate.place_ship(ship)
    end
  end
end