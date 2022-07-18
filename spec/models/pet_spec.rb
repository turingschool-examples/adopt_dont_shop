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

    describe '.not_adoptable' do
      it 'makes adoptable false' do
        @pet_1.not_adoptable
        expect(@pet_1.adoptable).to be(false)
      end
    end

    describe '.already_accepted?' do
      it 'returns boolean if pet has been accepted on any  apps' do
        app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "accepted")
        PetApp.create!(pet: @pet_1, app: app_1, approval: 'Approved')
        expect(@pet_1.already_accepted?).to be(true)
      end
    end

    describe '.pet_app_approval(app)' do
      it 'returns petapp approval for app argument' do
        pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "accepted")
        PetApp.create!(pet: pet_1, app: app_1, approval: 'Approved')
        expect(pet_1.pet_app_approval(app_1)).to eq('Approved')
      end
    end
  end
end
