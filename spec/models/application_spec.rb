require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
    it { should have_many(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_length_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
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
    @pet_5 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter_1.id)
  end

  describe 'instance methods' do
    describe '.check_approval!' do
      it 'changes the status of an application to approved if all pets are approved' do
        @application_pets = @application.application_pets
        expect(@application.status).to eq('In Progress')
        @application.check_approval!
        expect(@application.status).to eq('In Progress')
        @application_pets.first.update(pet_status: 'Approved')
        @application.check_approval!
        expect(@application.status).to eq('In Progress')
        @application_pets.last.update(pet_status: 'Approved')
        @application.check_approval!
        expect(@application.status).to eq('Approved')
      end

      it 'changes the status of an application to rejected if any pets are rejected' do
        @application_pets = @application.application_pets
        expect(@application.status).to eq('In Progress')
        @application.check_approval!
        expect(@application.status).to eq('In Progress')
        @application_pets.first.update(pet_status: 'Approved')
        @application.check_approval!
        expect(@application.status).to eq('In Progress')
        @application_pets.last.update(pet_status: 'Rejected')
        @application.check_approval!
        expect(@application.status).to eq('Rejected')
      end
    end
  end
end
