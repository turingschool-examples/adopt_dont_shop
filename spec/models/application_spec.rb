require 'rails_helper'

RSpec.describe Application, type: :model do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application1 = Application.create!(name: "Suzie Q", street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, statement: "TEST", status: 'Pending')
    @application2 = Application.create!(name: "Jane Doe", street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, statement: "TEST", status: 'Pending')
    @application3 = Application.create!(name: "Barak Obama", street_address: '1600 Pennsylvania Ave', city: 'Washington', state: 'DC', zip_code: 20500, statement: "TEST", status: 'Pending')

    @application_pet1 = ApplicationPet.create!(application: @application1, pet: @pet_1, status: 'Rejected')
    @application_pet2 = ApplicationPet.create!(application: @application2, pet: @pet_3, status: 'Approved')
    @application_pet3 = ApplicationPet.create!(application: @application3, pet: @pet_2)
  end

  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'class methods' do
    describe '#filter_by_pending' do
      it 'returns only application_ids for pending apps' do
        expect(Application.filter_by_pending.first).to eq(@application1.id)
        expect(Application.filter_by_pending.last).to eq(@application3.id)
      end
    end
  end
  describe 'instance methods' do
    describe '#evaluate_status' do
      it 'evaluates the status of each pet on an application and updates the application status accordingly' do
        @application1.evaluate_status

        expect(@application1.status).to eq('Rejected')

        @application2.evaluate_status

        expect(@application2.status).to eq('Approved')

        @application3.evaluate_status

        expect(@application3.status).to eq('Pending')
      end
    end
  end
end