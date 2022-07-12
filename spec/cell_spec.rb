require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  let(:cell) {described_class.new("B4")}
  let(:cruiser) {Ship.new("Cruiser", 3)}

  it '1. exists' do
    expect(cell).to be_instance_of(described_class)
  end

  it '2. has coordinates' do
    expect(cell.coordinate).to eq("B4")
  end

  it '3. has ship' do
    expect(cell.ship).to eq(nil)
  end

  it '4. is empty by default' do
    expect(cell.empty?).to eq(true)
  end

  it '5. ship can be placed' do
    cell.place_ship(cruiser)

    expect(cell.ship).to be_instance_of(Ship)
    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to eq(false)
  end

  it '6. is not fired upon by default' do
    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to eq(false)
  end

  it '7. can be fired upon' do
    cell.place_ship(cruiser)
    cell.fire_upon
    
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to eq(true)
  end
end