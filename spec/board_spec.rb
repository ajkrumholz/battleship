require './lib/board'
require 'pry'

RSpec.describe Board do
  let(:board) {described_class.new}

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
end