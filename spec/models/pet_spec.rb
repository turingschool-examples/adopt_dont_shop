require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    PetApplication.destroy_all
    Shelter.destroy_all
    Pet.destroy_all
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Englewood shelter', city: 'Englewood, CO', foster_program: true, rank: 4)
    @application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", status: "Pending")
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @pet_4 = @shelter_2.pets.create(name: 'Henry', breed: 'doggo', age: 7, adoptable: false)
    @application_1.pets << @pet_1
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
 
    describe '#match' do 
      it 'allows for partial matches for pet names' do
        expect(Pet.match("pirate")).to eq([@pet_1])
        expect(Pet.match("clAw")).to eq([@pet_2])
        expect(Pet.match("an")).to eq([@pet_3])
      end 
    end 

    describe '#pending_pets' do 
      it 'returns pets that have pending applications' do 
        expect(Pet.pending_pets).to eq([@pet_1])
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
