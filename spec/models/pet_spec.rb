require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }

    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
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

    describe "#approved?" do
      it 'should return false if application_pet is pending' do
        application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: [@pet_1.name, @pet_2.name])
      
        application_pet = ApplicationPet.create!(pet_id: @pet_1.id, application_id: application_1.id)
        
        expect(@pet_1.approved?(application_1.id)).to eq(false)
      end

      it 'should return true if application_pet is accepted' do
        application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, pets_on_app: [@pet_2.name])
    
        application_pet = ApplicationPet.create!(pet_id: @pet_2.id, application_id: application_1.id, pet_status: "Accepted")
      
        expect(@pet_2.approved?(application_1.id)).to eq(true)
      end
    end

    describe "#rejected?" do
      it 'should return true if application_pet is rejected' do
        application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: [@pet_1.name, @pet_2.name])
      
        application_pet = ApplicationPet.create!(pet_id: @pet_1.id, application_id: application_1.id, pet_status: "Rejected")
        
        expect(@pet_1.rejected?(application_1.id)).to eq(true)
      end

      it 'should return false if application_pet is accepted or pending' do
        application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, pets_on_app: [@pet_2.name])
    
        application_pet = ApplicationPet.create!(pet_id: @pet_2.id, application_id: application_1.id, pet_status: "Accepted")
      
        expect(@pet_2.rejected?(application_1.id)).to eq(false)
      end
    end
  end
end
