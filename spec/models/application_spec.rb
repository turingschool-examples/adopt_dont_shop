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

  # describe 'adding pets' do
  #   before :each do
  #     @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #     @pirate = @shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
  #     @gaspir = @shelter.pets.create(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
  #     @joey = @shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)
  #
  #     @app_1 = Application.create!(
  #       name: "Jerry Blank",
  #       street_address: "246 DumDum Ave.",
  #       city: "Melbourne",
  #       state: "IL",
  #       zip_code: 53262,
  #       description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
  #       status: "In Progress"
  #     )
  #   end
  #
  #   it 'adds a pet to an application' do
  #     @app_1.add_pet(@pirate)
  #     expect(@app_1.pets).to eq([@pirate])
  #   end
  #
  #   it 'adds multiple pets to an application' do
  #     @app_1.add_pet(@pirate)
  #     @app_1.add_pet(@gaspir)
  #     @app_1.add_pet(@joey)
  #     expect(@app_1.pets).to eq([@pirate, @gaspir, @joey])
  #   end
  # end
end
