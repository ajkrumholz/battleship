require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

RSpec.describe Game do
  let(:game) { described_class.new }
  let(:player) { Player.new }
  let(:board) { Board.new(4, 4) }

  it '1. exists as a Game' do
    expect(game).to be_instance_of(Game)
  end

  it '2. has shot potentials' do
    cell_1 = player.board.cells['A1']
    cell_2 = player.board.cells['A2']
    cell_3 = player.board.cells['A3']

    expect(game.computer_shot_potentials).to eq(player.board.cells.keys)
  end
end
