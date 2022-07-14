require './lib/board'
require './lib/ship'
require 'pry'

RSpec.describe Board do
  let(:board) {described_class.new}
  let(:submarine) {Ship.new("Submarine", 2)}
  let(:cruiser) {Ship.new("Cruiser", 3)}

  it '1. exists' do
    expect(board).to be_instance_of(Board)
  end

  it '2. hash has cell instances and size' do
    expect(board.cells.size).to eq(16)
    expect(board.cells.values[0]).to be_instance_of(Cell)
  end

  it '3. validates coordinates' do
    expect(board.valid_coordinate?("A1")).to eq(true)
    expect(board.valid_coordinate?("D4")).to eq(true)
    expect(board.valid_coordinate?("A5")).to eq(false)
    expect(board.valid_coordinate?("E1")).to eq(false)
    expect(board.valid_coordinate?("A22")).to eq(false)
  end

  it '4. validates ship placements with length' do
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to eq(true)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
  end

  it '5. validates placement coordinates are consecutive' do
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
  end

  it '6. can place ships in cells' do
    cell_1 = board.cells["A1"]  
    cell_2 = board.cells["A2"]  
    cell_3 = board.cells["A3"]  
    board.place(cruiser, [cell_1, cell_2, cell_3]) 

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship == cell_2.ship).to eq(true)
  end
end