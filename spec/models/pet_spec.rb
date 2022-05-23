require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many :pet_applications }
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

    describe '.app_status' do
      it 'retrieves the pet_application status based off arguments' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

        application1 = Application.create!(
            name: 'Waldo Werziat',
            street_address: '-1 Bermuda trgl',
            city: 'Atlantis',
            state: 'Confusion',
            zip_code: 42070,
            description: "I'm really lonely.",
            status: 'Pending'
        )

        application2 = Application.create!(
            name: 'Carol Baskins',
            street_address: '12802 Easy St',
            city: 'Tampa',
            state: 'FL',
            zip_code: 33625,
            description: 'I just really love animals more than that other guy',
            status: 'Pending'
        )

        pet_application_1 = PetApplication.create!(pet: pet_1, application: application1)
        pet_application_2 = PetApplication.create!(pet: pet_2, application: application1, status: "Approved")
        pet_application_3 = PetApplication.create!(pet: pet_1, application: application2, status: "Rejected")

        expect(pet_1.app_status(pet_1.id, application1.id)).to eq(NULL)
        expect(pet_2.app_status(pet_2.id, application1.id)).to eq("Approved")
        expect(pet_1.app_status(pet_1.id, application2.id)).to eq("Rejected")
      end
    end
  end
end
