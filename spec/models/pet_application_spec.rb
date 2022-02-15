require 'rails_helper'

RSpec.describe PetApplication do



  it { should belong_to :application }
  it { should belong_to :pet }

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application = Application.create!(name: "Chaz Carmichael",
      street_address: "10 lane",
      city: "Sandy Springs",
      state: "CO",
      zipcode: 12345)
    @pet_application = PetApplication.create!(application_id: @application.id, pet_id: @pet_3.id)
  end

  describe '.app_status' do
    it 'returns the application of a pet' do
      expect(PetApplication.pet_app(@application.id,@pet_3.id)).to eq(@pet_application)
    end
  end
end
