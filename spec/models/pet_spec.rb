require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
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

    @application_pet1 = ApplicationPet.create!(application: @application1, pet: @pet_1)
    @application_pet2 = ApplicationPet.create!(application: @application2, pet: @pet_3)
    @application_pet3 = ApplicationPet.create!(application: @application3, pet: @pet_2)
    @application_pet4 = ApplicationPet.create!(application: @application3, pet: @pet_1, status: 'Approved')
    @application_pet5 = ApplicationPet.create!(application: @application2, pet: @pet_1, status: 'Rejected')
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#search_by_name' do
      it 'returns partial matches' do
        expect(Pet.search_by_name("Claw")).to eq([@pet_2])
      end
      it 'returns exact matches' do
        expect(Pet.search_by_name("Clawdia")).to eq([@pet_2])
      end
      it 'performs a case insensitive search' do
        expect(Pet.search_by_name("ClaWDia")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_2, @pet_3, @pet_4])
      end
    end

    describe '#filter_by_pending_apps' do
      it 'returns shelter_ids for only pets with pending apps' do
        expect(Pet.filter_by_pending_apps.first).to eq(@pet_1.shelter_id)
        expect(Pet.filter_by_pending_apps.last).to eq(@pet_3.shelter_id)
      end
    end
  end

  describe 'instance methods' do
    describe '#shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_3.name)
      end
    end
    describe '#application status' do
      it 'returns the status for a given application/pet pair' do
        expect(@pet_1.application_status(@application3.id)).to eq('Approved')
        expect(@pet_1.application_status(@application2.id)).to eq('Rejected')
        expect(@pet_3.application_status(@application1.id)).to eq(nil)
      end
    end
    describe '#approved_on_other_apps?' do
      it 'tells you if the pet is approved on other apps' do
        expect(@pet_1.approved_on_other_apps?(@application1.id)).to eq(true)
        expect(@pet_3.approved_on_other_apps?(@application2.id)).to eq(nil)
      end
    end
  end
end
