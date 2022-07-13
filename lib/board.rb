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
    coord_arr = @letters.map do |letter|
      letter = (letter + 64).chr
        @numbers.map do |number|
          "#{letter}#{number}"
        end
    end.flatten
  end
end