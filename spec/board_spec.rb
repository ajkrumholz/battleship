require './lib/board'
require 'pry'

RSpec.describe Board do
  let(:board) {described_class.new}

  it '1. exists' do
    expect(board).to be_instance_of(Board)
  end

  it '2. hash has cell instances and size' do
    expect(board.cells.size).to eq(16)
    # expect(board.cells.values[0]).to be_instance_of(Cell)
  end
end