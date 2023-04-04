require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications)}
    it { should have_many(:applications).through(:pet_applications)}
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
    @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals", status: "Pending")
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        @pet_4 = @shelter_1.pets.create(name: 'bindle', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_5 = @shelter_1.pets.create(name: 'quagbindle', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_6 = @shelter_1.pets.create(name: 'BINDLEsticks', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_7 = @shelter_1.pets.create(name: 'Sir binDletonshiresworth', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        
        expect(Pet.search("bindle").to_a).to eq([@pet_4, @pet_5, @pet_6, @pet_7])
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

    describe 'pets_adopted' do
      it 'updates pet adoptable status to false' do
        @pet_1.pet_adopted
        
        expect(@pet_1.adoptable).to eq(false)
      end
    end
  end
end
