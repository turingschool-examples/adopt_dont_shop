require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications) }
    it { should have_many(:applications).through(:pet_applications) }
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

    describe '#pet_app' do
      it 'returns the pet application for a given pet' do
        application = Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 1)
        pet_app = PetApplication.create!(pet: @pet_1, application: application)

        expect(@pet_1.pet_app(application)).to eq(pet_app)
      end
    end

    describe '#has_accepted_application' do
      it 'returns true or false if the pet has an accepted application' do

        application_1 = Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 1)
        application_2 = Application.create!(name: 'Thomas', address: '456 W Side', city: 'Denver', state: 'CO', zip: '80123', description: 'I love animals more!', status: 2)
        pet_app_1 = PetApplication.create!(pet: @pet_1, application: application_1)
        pet_app_2 = PetApplication.create!(pet: @pet_1, application: application_2)
        
        expect(@pet_1.has_accepted_application(application_1)).to be true
        expect(@pet_1.has_accepted_application(application_2)).to be false
      end
    end
  end
end
