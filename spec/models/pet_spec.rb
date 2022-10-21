require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @scooby = @shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @sm_scooby = @shelter.pets.create!(name: 'Scooby', age: 6, breed: 'Chihuahua', adoptable: true)
    @scrappy = @shelter.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2, @scooby, @sm_scooby, @scrappy])
      end
    end

    describe '#pet_name_filter' do
      it 'returns all of the pets with a specific name' do
        expect(Pet.pet_name_filter("Scooby")).to eq([@scooby, @sm_scooby])
      end

      it 'returns all pets partial matches to the name searched' do
        fluff = @shelter.pets.create!(name: 'fluff', age: 6, breed: 'Chihuahua', adoptable: true)
        mr_fluff = @shelter.pets.create!(name: 'mr. fluff', age: 2, breed: 'Dalmation', adoptable: true)
        fluffy = @shelter.pets.create!(name: 'fluffy', age: 1, breed: 'Chihuahua', adoptable: true)

        expect(Pet.pet_name_filter("fluff")).to eq([fluff, mr_fluff, fluffy])
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
end
