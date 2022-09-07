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

    describe '#order_alpha' do
      it 'orders shelters alpha descending' do
        expect(Shelter.order_alpha).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#pending_apps' do
      it 'displays shelters with pending apps' do
        @beldof = @shelter_1.apps.create!(
          name: "Gob Beldof", 
          address: "152 Animal Ave.", 
          city: "Omaha, NE", 
          zip_code: "19593",
          description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
          status: "Pending"
        )
        @garbo = @shelter_2.apps.create!(
          name: "Luut Garbo",
          address: "asdf",
          city: "asdfa",
          zip_code: "asdfs",
          description: "asdfaw",
          status: "Pending",
        )
        
        @smooch = @shelter_3.apps.create!(
          name: "Carter Smooch",
          address: " asdgw",
          city: "asdgwe",
          zip_code: "agwef",
          description: "asdhge",
          status: "In Progress",
        )

        expect(Shelter.pending_apps).to include(@shelter_1, @shelter_2)
        expect(Shelter.pending_apps).to_not include(@shelter_3)
      end
    end

    describe 'info' do
      it 'returns an object from Shelter with only name and city' do
        shelter = Shelter.info(@shelter_1.id)
        expect(shelter.name).to eq("Aurora shelter")
        expect(shelter.city).to eq("Aurora, CO")
        expect(shelter.pets).to eq([])
        expect(shelter).to_not have_attribute(:rank)
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

    describe '.average_pet_age' do
      it 'returns the average age of shelters pets' do
        expect(@shelter_1.average_pet_age).to eq(4.33)
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

    describe 'num_adoptable_pets' do
      it 'returns the number of adoptable pets' do
        expect(@shelter_1.num_adoptable_pets).to eq(2)
      end
    end

    describe 'num_pets_adopted' do
      it 'returns the num of pets who have been adopted' do
        expect(@shelter_1.num_pets_adopted).to eq(1)
      end
    end
  end
end
