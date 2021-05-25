require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Coon City', street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Cat Savers', street_address: '1455 High St', city: 'Denver', state: 'CO', zip_code: 80218, foster_program: true, rank: 10)

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
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Cat")).to eq([@shelter_3])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#order_by_alphabetical' do
      it 'orders the shelters by name in reverse alphabetical order' do
        expect(Shelter.order_by_alphabetical).to eq([@shelter_1, @shelter_2, @shelter_3])
      end
    end

    describe '#filter_by_pending_apps' do
      it 'returns only shelters with pending apps' do
        expect(Shelter.filter_by_pending_apps.first).to eq(@shelter_1)
        expect(Shelter.filter_by_pending_apps.last).to eq(@shelter_3)
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '.sql_name' do
      it 'returns the name of any given shelter' do

        expect(@shelter_1.sql_name).to eq('Fluffy Friends')
      end
    end

    describe '.sql_full_address' do
      it 'returns the full address of any given shelter' do
        expect(@shelter_1.sql_full_address).to eq('1311 E 27th Ave Denver CO 80205')
      end
    end
  end
end
