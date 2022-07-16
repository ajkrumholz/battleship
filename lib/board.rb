require './lib/cell'
require 'pry'

class Board
  attr_reader :numbers, 
              :letters, 
              :rows, 
              :columns
  attr_accessor :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"), "A2" => Cell.new("A2"), "A3" => Cell.new("A3"), "A4" => Cell.new("A4"), "B1" => Cell.new("B1"), "B2" => Cell.new("B2"), "B3" => Cell.new("B3"), "B4" => Cell.new("B4"), "C1" => Cell.new("C1"), "C2" => Cell.new("C2"), "C3" => Cell.new("C3"), "C4" => Cell.new("C4"), "D1" => Cell.new("D1"), "D2" => Cell.new("D2"), "D3" => Cell.new("D3"), "D4" => Cell.new("D4")
             }
    @rows = 4
    @columns = 4
    @numbers = [1, 2, 3, 4]
    @letters = ["A", "B", "C", "D"]
  end

  # def cells
  #   @cells = 
  # end
  #   cell_hash = {}
  #   coord_arr = @letters.flat_map do |letter|
  #     letter = (letter + 64).chr
  #       @numbers.flat_map do |number|
  #         cell = Cell.new("#{letter}#{number}")
  #         cell_hash[cell.coordinate] = cell
  #       end
  #     end
  #   cell_hash
  

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end 

  def place(ship, cell_array)
    cell_array.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end
  
  def valid_placement?(ship, coordinates)
    valid_placement_length?(ship, coordinates) && consecutive_coordinates?(coordinates) && overlapping(coordinates)
  end

  def valid_placement_length?(ship, coordinates)
    coordinates.uniq.count == ship.length
  end

  # def consecutive_coordinates?(coordinates)
  #   consecutive_letters(coordinates) && consecutive_numbers(coordinates)
  # end
    # # placement_coords.sort == placement_coords
    # letters = []
    # numbers = []
    # coordinates.each do |coordinate|
    #   letters << coordinate.split('')[0]
    #   numbers << coordinate.split('')[1]
    # end

  def consecutive_coordinates?(coordinates)
    letters = coordinates.map { |coordinate| coordinate.split('')[0] }
    numbers = coordinates.map { |coordinate| coordinate.split('')[1] }
    if letters.uniq.count == numbers.uniq.count
      return false
    elsif letters.uniq.count != 1
      letters.each_cons(2).all? { |a,b| a.ord == b.ord - 1 }
    elsif numbers.uniq.count != 1
      numbers.each_cons(2).all? { |a,b| a.to_i == b.to_i - 1 }
    end
  end

  def overlapping(coordinates)
    coordinates.all? do |coordinate|
      cells[coordinate].ship == nil
    end
  end

  # def consecutive_numbers(coordinates)
  #   numbers = coordinates.map { |coordinate| coordinate.split('')[1]}
  #   if numbers.uniq.count != 1
  #     numbers.each_cons(2).all? { |a,b| a.to_i == b.to_i - 1 }
  #   else
  #     true
  #   end
  # end
    # if letters.uniq.count == 1 && numbers.uniq.count != 1
    #   numbers.each_cons(2).all? { |a,b| a.to_i == b.to_i - 1 }

    # elsif numbers.uniq.count == 1 && letters.uniq.count != 1
    #   letters.each_cons(2).all? { |a,b| a.ord == b.ord - 1 }
    # end
    


  def render(state = false)
    render_array = (cells.values.map { |cell| cell.render(state) }).each_slice(4).to_a
    "  1 2 3 4 \n" + 
    "A " + render_array[0].join(' ') + " \n" +
    "B " + render_array[1].join(' ') + " \n" +
    "C " + render_array[2].join(' ') + " \n" +
    "D " + render_array[3].join(' ') + " \n"
  end
end
  # code below helps make more scaleable
  #   letters = []
  #   numbers = []
  #   cells.keys.each do |coord|
  #     letters << coord.split('')[0]
  #     numbers << coord.split('')[1]
  #   end
  #   header = "  #{numbers.uniq.join(' ')} \n"
  #   board_display = []
  #   letters.uniq.each do |letter|
  #     board_display << "#{letter} "
  #     cells.values.each do |cell|
  #       if cell.coordinate[0] == letter
  #         if state == false
  #         board_display << "#{cell.render} "
  #         elsif state == true
  #         board_display << "#{cell.render(true)} "
  #         end
  #       end
  #     end
  #     board_display << "\n"   
  #   end
  #   header + board_display.join
  # end