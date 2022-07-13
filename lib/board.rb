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
end