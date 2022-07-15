# require './lib/board'
# require './lib/cell'
# require './lib/ship'
require './lib/game'
require './lib/computer'
require 'pry'

RSpec.describe Computer do
  let(:computer) {described_class.new}
  # let(:board) {Board.new}
  # let(:cruiser) {Ship.new("Cruiser", 3)}
  # let(:sub) {Ship.new("Submarine", 2)}
  let(:game) {Game.new}


  it '' do
    computer.comp_ship_place
  end

end