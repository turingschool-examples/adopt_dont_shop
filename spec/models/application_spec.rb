require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { validate_presence_of(:city)}
    it { validate_presence_of(:zip)}
    it { validate_presence_of(:street)}
    it { validate_presence_of(:state)}
    it { validate_presence_of(:name)}
    it { validate_presence_of(:description)}

    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'class methods' do
    it 'returns only pending applications' do
      derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 }, status: "Pending")
      jim = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 }, status: "Pending")
      billy = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 })

      expect(Application.pending).to eq([derek, jim])
    end
  end
end
