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

  def render(state = false)
    if @fired_upon == false
      if state == true && @ship != nil
        "S"
      else
        "."      
      end
    elsif @fired_upon == true
      if @ship == nil
        "M"
      else
        if @ship.health == 0
          "X"
        else
          "H"
        end
      end
    end
  end  
end