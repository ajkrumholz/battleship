require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  let(:cell) {described_class.new("B4")}

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
end