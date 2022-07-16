require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require './lib/computer'
require 'pry'

RSpec.describe Computer do
  let(:game) {Game.new}
  let(:computer) {described_class.new}
  let(:player) {Player.new}


  it 'exists' do
    expect(computer).to be_instance_of(described_class)
  end

  it 'has ships by default' do
    expect(computer.cruiser.name).to eq("Cruiser")
    expect(computer.submarine.name).to eq("Submarine")
  end
  
  it 'places ships at random' do
    computer.board.build_board
    computer.place_cruiser
    computer.place_submarine

    expect(computer.board.cells.values.any? { |cell| cell.ship != nil}).to eq(true)
  end
end