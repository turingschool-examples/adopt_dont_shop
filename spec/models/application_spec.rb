require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  describe '.all_pets_approved' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: true)
      @application = Application.create!(name: "Chaz Carmichael",
        street_address: "10 lane",
        city: "Sandy Springs",
        state: "CO",
        zipcode: 12345)
      @application2 = Application.create!(name: "Jell",
        street_address: "2 Still mill",
        city: "Caporwoods",
        state: "NE",
        zipcode: 78923)
      @pet_application = PetApplication.create!(application_id: @application.id, pet_id: @pet_2.id)
      @pet_application2 = PetApplication.create!(application_id: @application.id, pet_id: @pet_3.id)
      @pet_application3 = PetApplication.create!(application_id: @application2.id, pet_id: @pet_2.id)
      @pet_application4 = PetApplication.create!(application_id: @application2.id, pet_id: @pet_3.id)

      @pet_application.status = "1"
      @pet_application2.status = "1"
      @pet_application.save
      @pet_application2.save

      @pet_application3.status = "0"
      @pet_application4.status = "0"
      @pet_application3.save
      @pet_application4.save
    end

    it 'returns true if all pet apps approved to be adopted' do
      expect(@application.all_pets_approved).to eq(true)
    end

    it 'returns true if all pet apps have a status of rejected or approved' do
      expect(@application2.rejected_or_approved).to eq(false)
      expect(@application.all_pets_approved).to eq(true)
    end
  end
end
