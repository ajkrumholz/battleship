require './lib/ship'

RSpec.describe Ship do
  let(:ship) { described_class.new('Cruiser', 3) }

  it '1. exists' do
    expect(ship).to be_instance_of(described_class)
  end

  it '2. has a name and length' do
    expect(ship.name).to eq('Cruiser')
    expect(ship.length).to eq(3)
  end

  it '3. has health' do
    expect(ship.health).to eq(3)
  end

  it '4. is not sunk by default' do
    expect(ship.sunk?).to eq(false)
  end

  it '5. can be hit' do
    ship.hit

    expect(ship.health).to eq(2)
    expect(ship.sunk?).to eq(false)
  end

  it '6. can be hit twice' do
    ship.hit
    ship.hit

    expect(ship.health).to eq(1)
    expect(ship.sunk?).to eq(false)
  end

  it '7. can be sunk' do
    ship.hit
    ship.hit
    ship.hit

    expect(ship.health).to eq(0)
    expect(ship.sunk?).to eq(true)
  end
end
