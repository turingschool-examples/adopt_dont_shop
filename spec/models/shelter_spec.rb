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
    it { should validate_presence_of(:street_address) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:state) }
  end

  before(:each) do
    @larry_application = Application.create!(name: "Larry Bird", street_address: "456 Boston Road", city: "Boston", state: "MA", zip_code: 67891, description: "Dogs Love Me", status: "Pending")

    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora', foster_program: false, rank: 9, street_address: "123 Old Road", zip_code: 54689, state: 'CO')
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen', foster_program: false, rank: 5, street_address: "9898 Heaven Drive", zip_code: 87954, state: 'TX')
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver', foster_program: true, rank: 10, street_address: "989 Nike Lane", zip_code: 12548, state: "CO")

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @pet4_application = PetApplication.create!(application_id: @larry_application.id, pet_id: @pet_4.id, status: @larry_application.status)
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

    describe '#pending_applications' do
      it 'returns shelters that have pending applications' do
        expect(Shelter.pending_applications).to eq([@shelter_1])
      end
    end
    describe '#name_and_full_address' do
      it 'returns name and full address of specified shelter' do
        expect(Shelter.name_and_full_address(@shelter_2.id).name).to eq("RGV animal shelter")
        expect(Shelter.name_and_full_address(@shelter_2.id).city).to eq("Harlingen")
        expect(Shelter.name_and_full_address(@shelter_2.id).street_address).to eq("9898 Heaven Drive")
        expect(Shelter.name_and_full_address(@shelter_2.id).state).to eq("TX")
        expect(Shelter.name_and_full_address(@shelter_2.id).zip_code).to eq(87954)
      end
    end
    describe '#descending_order' do
      it 'returns the shelters in reverse alphabetical order' do
        expect(Shelter.descending_order).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end
    describe '#alphabetical_order' do
      it 'returns the shelters in alphabetical order' do
        expect(Shelter.alphabetical_order).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
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
      it 'returns the average of all adoptable pets for a given shelter' do
        expect(@shelter_1.average_age).to eq(4)
      end
    end
  end
end
