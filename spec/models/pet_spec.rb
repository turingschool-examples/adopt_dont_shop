require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it {should belong_to(:shelter) }
    it {should have_many(:application_pets)}
    it {should have_many(:applications).through(:application_pets)}
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
    @john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", status: 'Pending')
    @jane_johnson_app = Application.create!(name: 'Jane Johnson', street_address: '2548 Bungalow Ave', city: 'Spokane', state: 'WA', zip_code: 27338, description: 'I like cats. Give me some.', status: 'Pending')

    @john_doe_app.pets << @pet_1
    @jane_johnson_app.pets << [@pet_2, @pet_1]
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

    describe '.pending_apps' do
      it 'returns a collection of applications that include the pet and are in pending status' do
        expect(@pet_1.pending_apps).to eq([@john_doe_app, @jane_johnson_app])
        expect(@pet_2.pending_apps).to eq([@jane_johnson_app])
        expect(@pet_3.pending_apps).to eq([])
      end
    end
  end


end
