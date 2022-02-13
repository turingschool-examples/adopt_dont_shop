require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'adding pets' do
    it 'adds pets to an application' do
      app = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pirate = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      gaspir = shelter.pets.create(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
      joey = shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)

      expect(app.pets).to eq([])

      app.add_pet(pirate)
      expect(app.pets).to eq([pirate])

      app.add_pet(gaspir)
      expect(app.pets).to eq([pirate, gaspir])

      app.add_pet(joey)
      expect(app.pets).to eq([pirate, gaspir, joey])

    end
  end
end
