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
    it { should validate_length_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search('Fancy')).to eq([@shelter_3])
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

    describe '#shelters_with_pending_apps' do
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
      it 'returns table of shelters with in-progress applications' do
        expect(Shelter.shelters_with_pending_apps).to eq([@shelter_1])
      end
    end

    describe '#order_by_name desc' do
      it 'returns list of shelters in reverse alphabetical order' do
        expect(Shelter.order_by_name_desc).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#order_by_name asc' do
      it 'returns list of shelters in alphabetical order' do
        expect(Shelter.order_by_name_asc).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#find_shelter_raw' do
      it 'returns a shelter given an id' do
        expect(Shelter.find_shelter_raw(@shelter_1.id)).to eq(@shelter_1)
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

    describe '.average_age' do
      it 'returns the average age of the pets at the given shelter' do
        expect(@shelter_1.average_age).to eq 4
      end
    end
  end
end
