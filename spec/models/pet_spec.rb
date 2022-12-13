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
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search('Claw')).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    before :each do
      @application = Application.create({
                                          name: 'Jeff',
                                          street_address: '123 Main Street',
                                          city: 'Denver',
                                          state: 'CO',
                                          zip_code: 22_314,
                                          reason: 'Nice person'
                                        })

      @pet_4 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                        shelter_id: @shelter_1.id)
      @pet_5 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin',
                                        shelter_id: @shelter_1.id)
    end

    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe '.application_status' do
      it 'returns a boolean depending on the status of an application pet' do
        expect(@pet_4.application_status(@application.id)).to eq('Pending')

        app_pet = ApplicationPet.find_application_pet(@application.id, @pet_4.id)
        app_pet.update(pet_status: 'Approved')

        expect(@pet_4.application_status(@application.id)).to eq('Approved')
      end
    end
  end
end
