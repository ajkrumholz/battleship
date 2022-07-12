require 'pry'

class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @ship.hit if @ship != nil
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render
    if @ship == nil
      if @fired_upon == false
        "."
      else
        "M"
      end
    end
  end



  
end