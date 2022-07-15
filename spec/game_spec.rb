require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'
require 'pry'

RSpec.describe Game do
  let(:game) {described_class.new}

  it '1. exists as a Game' do
    expect(game).to be_instance_of(Game)
  end
  
end