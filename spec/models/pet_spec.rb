require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }

    it { should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before  :each do
    @application1 = Application.new
    @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill', shelter_id: @shelter_1.id)
    @application.pets << @pet_1
    @pet_application = PetApplication.create(pet_id: @pet_1.id, application_id: @application.id)
  end

  describe 'class methods' do
    describe 'search_pets' do
      it 'can search for pets with partial match' do
        expect(Pet.search('Ham')).to eq([@pet_2])
      end
   
      it 'can search for pets regardless of case' do
        expect(Pet.search('bArK hAmIlL')).to eq([@pet_2])
      end

      it 'can search for pets with a partial match, regardless of case' do
        expect(Pet.search('Il')).to eq([@pet_1, @pet_2])
      end
    end
 
    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end

    describe '#application_status_pet_name' do
      it 'returns the pet for specified application' do
        expect(Pet.application_status_pet_name(@application.id).first.id).to eq(@pet_application.id)
      end
    end

    describe 'instance methods' do
      describe '.shelter_name' do
        it 'returns the shelter name for the given pet' do
          expect(@pet_2.shelter_name).to eq(@shelter_1.name)
        end
      end
    end
  end
end
