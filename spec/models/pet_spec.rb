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

    describe '.pending_applications' do
      it 'returns the applications for the given pet' do
        application1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                            state: 'NY', zipcode: 10_001)
        application2 = Application.create!(name: 'John ', street_address: '123 Main St', city: 'New York',
                                            state: 'NY', zipcode: 10_001)
        application3 = Application.create!(name: 'Jane Doe', street_address: '123 Main St', city: 'New York',
                                    state: 'NY', zipcode: 10_001)
        pet_application1 = PetApplication.create!(application_id: application1.id, pet_id: @pet_1.id, status: 'Pending')
        pet_application2 = PetApplication.create!(application_id: application2.id, pet_id: @pet_1.id, status: 'Pending')
        pet_application3 = PetApplication.create!(application_id: application3.id, pet_id: @pet_1.id, status: 'Rejected')

        expect(@pet_1.pending_applications.length).to eq(2)
        expect(@pet_1.pending_applications.first.id).to eq(application1.id)
      end
    end
  end
end
