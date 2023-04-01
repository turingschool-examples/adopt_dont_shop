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
    @application_1 = Application.create!(name: "John Doe", street_address: "123 Main St", city: "Denver", state: "CO", zip_code: "80202", description: "I love dogs", status: "In Progress")
    @application_2 = Application.create!(name: "John Doe", street_address: "123 Main St", city: "Denver", state: "CO", zip_code: "80202", description: "I love dogs", status: "In Progress")
    @application_pets_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
    @application_pets_2 = ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_3.id, status: 'Approved')
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

    describe 'pending?' do
      it 'returns true when the application is Pending' do
        expect(@pet_1.pending?(@application_pets_1.application_id)).to eq(true)
      end
      
      it 'returns false when the application status is not Pending' do
        expect(@pet_3.pending?(@application_pets_2.application_id)).to eq(false)
      end
    end

    describe '::search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end
  end
end
