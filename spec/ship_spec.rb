require './lib/ship'

RSpec.describe Ship do

    let(:ship) {described_class.new("Cruiser", 3)}

    it '1. exists' do

        expect(ship).to be_instance_of(described_class)
    end

    it '2. has a name and length' do

        expect(ship.name).to eq("Cruiser")
        expect(ship.length).to eq(3)
    end
end