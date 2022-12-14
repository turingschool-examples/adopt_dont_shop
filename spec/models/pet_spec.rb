require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application1 = @pet_1.applications.create!(name: "Max", street_address: "Made up St", city: "Denver", state: "CO", zip_code: "80000", description: "Love mix breeds. Lots of energy to play with a dog", status: "Pending")
    @application2 = @pet_3.applications.create!(name: "Alastair", street_address: "Fictional St", city: "Golden", state: "CO", zip_code: "80001", description: "Love big dogs. Great mountain walks on doorstep", status: "Pending")
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe '.application_status' do
    it 'returns the status of an application pet' do
      expect(@pet_3.application_status(@application2.id)).to eq('Pending')

      app_pet = ApplicationPet.find_by_application_id(@application2.id)
      app_pet.update(status: 'Approved')

      expect(@pet_3.application_status(@application2.id)).to eq('Approved')
    end
  end
end
