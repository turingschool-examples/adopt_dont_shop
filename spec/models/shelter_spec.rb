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
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
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

    describe '#reverse_alphabetical_order' do
      it 'orders the shelters in reverse alphabetical order' do
        expect(Shelter.reverse_alphabetical_order).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#has_pending_status' do
      it 'selects only those which have an application status of pending' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        shelter_4 = Shelter.create(name: 'No pets in shelter', city: 'Denver, CO', foster_program: true, rank: 15)

        app_1 = Application.create(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
        app_2 = Application.create(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
        app_3 = Application.create(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'pending', description: 'safe')
        app_4 = Application.create(name: 'No Pets', street: '20 Gath st', city: 'Marco', state: 'Florida', zip_code: 34145, application_status: 'in progress', description: 'safe')

        pet_5 = app_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_1.id)
        pet_6 = app_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: shelter_1.id)
        pet_7 = app_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: shelter_2.id)
        pet_8 = app_3.pets.create(name: 'Toby', breed: 'golden', age: 1, adoptable: true, shelter_id: shelter_3.id)

        expect(Shelter.has_pending_status.length).to eq(3)
      end
    end

    describe '#pending_ordered' do
      it 'takes the previously sorted shelters with pending applcations and sort them alphabetically' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        shelter_4 = Shelter.create(name: 'No pets in shelter', city: 'Denver, CO', foster_program: true, rank: 15)

        app_1 = Application.create(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
        app_2 = Application.create(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
        app_3 = Application.create(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'pending', description: 'safe')
        app_4 = Application.create(name: 'No Pets', street: '20 Gath st', city: 'Marco', state: 'Florida', zip_code: 34145, application_status: 'in progress', description: 'safe')

        pet_5 = app_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_1.id)
        pet_6 = app_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: shelter_1.id)
        pet_7 = app_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: shelter_2.id)
        pet_8 = app_3.pets.create(name: 'Toby', breed: 'golden', age: 1, adoptable: true, shelter_id: shelter_3.id)

        expect(Shelter.pending_ordered).to eq([shelter_1, shelter_3, shelter_2])
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
  end
end
