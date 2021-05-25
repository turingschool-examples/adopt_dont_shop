require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
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
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe 'class methods' do
    describe '#filter_by_pending_apps' do
      it 'returns only pet_ids for pets with pending apps' do

        expect(ApplicationPet.filter_by_pending_apps.first).to eq(@pet_1.id)
        expect(ApplicationPet.filter_by_pending_apps.last).to eq(@pet_2.id)
      end
    end
    describe '#rejected_pet_count_for_app' do
      it 'returns a count of how many pets have been rejected in a given app' do

        expect(ApplicationPet.rejected_pet_count_for_app(@application1.id)).to eq(1)
        expect(ApplicationPet.rejected_pet_count_for_app(@application2.id)).to eq(0)
      end
    end
    describe '#approved_pet_count_for_app' do
      it 'returns a count of how many pets have been rejected in a given app' do

        expect(ApplicationPet.approved_pet_count_for_app(@application1.id)).to eq(0)
        expect(ApplicationPet.approved_pet_count_for_app(@application2.id)).to eq(1)
      end
    end
  end

  describe 'instance methods' do
    describe '#find_record' do
      it 'returns only ApplicationPet record associated with a given pet/appp id' do
        expect(ApplicationPet.find_record(@pet_1.id, @application1.id)).to eq(@application_pet1)
      end
    end
  end
end