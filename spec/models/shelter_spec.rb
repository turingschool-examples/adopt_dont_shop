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


    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @applicant_1 = Applicant.create!(first_name: 'Jimmy', last_name: 'Dough', street_address: '567 Fake Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm awesome", status: 'Pending')
    @applicant_2 = Applicant.create!(first_name: 'Johnny', last_name: 'Johnson', street_address: '17 Psuedo Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm awesome", status: 'In Progress')
    @applicant_3= Applicant.create!(first_name: 'Timmy', last_name: 'Thompson', street_address: '57 Real Street', city: 'Denver',
      state: 'CO', zip: 80207, description: "I'm not so awesome", status: 'Pending')
    @applicant_4= Applicant.create!(first_name: 'Tommy', last_name: 'Timson', street_address: '12227 Real Blvd', city: 'Colorado Springs',
      state: 'CO', zip: 80909, description: "I'm the worst", status: 'Approved')

      @pet_1 = @applicant_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false, shelter_id: @shelter_1.id)
      @pet_2 = @applicant_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_2.id)
      @pet_3 = @applicant_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_3.id)
      @pet_4 = @applicant_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true, shelter_id: @shelter_1.id)
      @pet_5 = @applicant_1.pets.create!(name: 'frappacino', age: 2, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
      @pet_6 = @applicant_4.pets.create!(name: 'MR FROSTY', age: 3, breed: 'Mut', adoptable: true, shelter_id: @shelter_3.id)
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

    describe '#order_by_desc_alphabetically' do
      it 'returns shelters with in reverse alphabetical order' do
        expect(Shelter.order_by_desc_alphabetically).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#shelters_by_status' do
      it 'returns shelters by application status' do

        expect(Shelter.shelters_by_status).to eq([@shelter_1, @shelter_3])
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_4, @pet_5])
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_5])
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
