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
    @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", description:"I love dogs and would be such a good dog mom", status: "Approved")
    @application2 = Application.create!(name:"Dominic OD", street_address:"5250 Town and Country Blvd.", city:"Frisco", state:"Texas", zipcode:"75034", description:"I like cats.", status: "Approved")

    PetApplication.create!(pet: @pet_1, application: @application1, approved?: true, rejected?: false)
    PetApplication.create!(pet: @pet_2, application: @application1, approved?: false, rejected?: true)
    PetApplication.create!(pet: @pet_3, application: @application1, approved?: true, rejected?: false)
    PetApplication.create!(pet: @pet_1, application: @application2, approved?: false, rejected?: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
        expect(Pet.search("dia")).to eq([@pet_2])
        expect(Pet.search("a")).to eq([@pet_1, @pet_2, @pet_3])
      end

      it 'is case insensitive' do
        expect(Pet.search("CLAW")).to eq([@pet_2])
        expect(Pet.search("DiA")).to eq([@pet_2])
        expect(Pet.search("A")).to eq([@pet_1, @pet_2, @pet_3])
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

    describe '.app_approval?' do
      it 'can determine if a pet has been approved on a specific application' do
        expect(@pet_1.app_approval?(@pet_1.id, @application1.id)).to eq(true)
        expect(@pet_2.app_approval?(@pet_2.id, @application1.id)).to eq(false)
        expect(@pet_1.app_approval?(@pet_1.id, @application2.id)).to eq(false)
      end
    end

    describe '.app_rejected?' do
      it 'can determine if a pet has been rejected on a specific application' do
        expect(@pet_1.app_rejected?(@pet_1.id, @application1.id)).to eq(false)
        expect(@pet_2.app_rejected?(@pet_2.id, @application1.id)).to eq(true)
        expect(@pet_1.app_rejected?(@pet_1.id, @application2.id)).to eq(false)
        expect(@pet_3.app_rejected?(@pet_1.id, @application1.id)).to eq(false)
      end
    end
  end
end
