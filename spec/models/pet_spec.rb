require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:application_pets) }
    it { should have_many(:applications).through(:application_pets)}
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
    describe '.search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '.adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe '#has_pending_applications?' do
      context 'when it has pending applications' do
        it 'returns true' do
          application = Application.create!(
                                            name: "Nate Brown",
                                  street_address: "2000 35th Avenue",
                                            city: "Denver",
                                           state: "CO",
                                             zip: "90210",
                                          status: "Pending"
                                              )

          application.add_pet_to_application(@pet_3)
          
          expect(@pet_3.has_pending_applications?).to eq(true)
        end
      end
      context 'when it does not have pending applications' do
        it 'returns false' do
          expect(@pet_1.has_pending_applications?).to eq(false)
        end
      end
    end

    describe '#find_pending_applications' do
      it 'lists applications pet has that are pending' do
        application = Application.create!(
                                          name: "Nate Brown",
                                street_address: "2000 35th Avenue",
                                          city: "Denver",
                                         state: "CO",
                                           zip: "90210",
                                        status: "Pending"
                                            )
        application_2 = Application.create!(
                                          name: "James Brown",
                                street_address: "2000 Train Street",
                                          city: "San Fran",
                                         state: "CA",
                                           zip: "90210",
                                        status: "Rejected"
                                            )

        application.add_pet_to_application(@pet_3)
        application_2.add_pet_to_application(@pet_3)

        expect(@pet_3.find_pending_applications).to include(application)
        expect(@pet_3.find_pending_applications).to_not include(application_2)
      end
    end
  end
end
