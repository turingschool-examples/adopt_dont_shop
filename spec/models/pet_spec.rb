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

  describe '#approval' do
    it 'returns the status of an ApplicationPet object' do
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_2.pets.create!(name: 'Scooby', breed: 'Great Dane', age: 2, adoptable: true)
      @application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203')
      @pet_4 = @application_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_2.id)
      
      expect(@pet_4.approval(@application_1.id)).to eq('Pending')

    end
  end
end
