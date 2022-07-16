'new text'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require './lib/player'
require 'pry'

RSpec.describe Player do
  let(:player) {described_class.new}
  # let(:board) {Board.new}
  # let(:cruiser) {Ship.new("Cruiser", 3)}
  # let(:sub) {Ship.new("Submarine", 2)}
  let(:game) {Game.new}


  it '' do
    # player.place_cruiser
# binding.pry
  end

end