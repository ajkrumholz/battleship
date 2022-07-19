require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  let(:cell_1) { described_class.new('B4') }
  let(:cell_2) { described_class.new('C3') }
  let(:cruiser) { Ship.new('Cruiser', 3) }

  it '1. exists' do
    expect(cell_1).to be_instance_of(described_class)
  end

  it '2. has coordinates' do
    expect(cell_1.coordinate).to eq('B4')
  end

  it '3. has ship' do
    expect(cell_1.ship).to eq(nil)
  end

  it '4. is empty by default' do
    expect(cell_1.empty?).to eq(true)
  end

  it '5. ship can be placed' do
    cell_1.place_ship(cruiser)

    expect(cell_1.ship).to be_instance_of(Ship)
    expect(cell_1.ship).to eq(cruiser)
    expect(cell_1.empty?).to eq(false)
  end

  it '6. is not fired upon by default' do
    cell_1.place_ship(cruiser)

    expect(cell_1.fired_upon?).to eq(false)
  end

  it '7. can be fired upon' do
    cell_1.place_ship(cruiser)
    cell_1.fire_upon

    expect(cell_1.ship.health).to eq(2)
    expect(cell_1.fired_upon?).to eq(true)
  end

  it '8. renders a cell with default "."' do
    expect(cell_1.render).to eq('.')
  end

  it '9. registers a miss' do
    cell_1.fire_upon

    expect(cell_1.render).to eq('M')
  end

  it '10. place ship and render "."' do
    cell_2.place_ship(cruiser)

    expect(cell_2.render).to eq('.')
  end

  it '11. can reveal hidden ships' do
    cell_2.place_ship(cruiser)

    expect(cell_2.render(true)).to eq('S')
  end

  it '12. can render hits and sinkings' do
    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    expect(cell_2.render).to eq('H')
    expect(cruiser.sunk?).to eq(false)

    cruiser.hit
    cruiser.hit
    expect(cell_2.render).to eq('X')
    expect(cruiser.sunk?).to eq(true)
  end
end
