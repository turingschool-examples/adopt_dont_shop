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
    @pet_5 = @shelter_2.pets.create(name: 'Teddy', breed: 'terrier', age: 12, adoptable: true)
    @pet_6 = @shelter_3.pets.create(name: 'Gracie', breed: 'sphynx', age: 9, adoptable: true)

  end

  describe 'class methods' do
    describe '.search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe '.order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '.order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '.order_reverse_alphabetically' do
      it 'sorts the shelters in reverse alphabetical order' do
        expect(Shelter.order_reverse_alphabetically).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '.order_pending_alphabetically' do
      it 'sorts the pending shelters in alphabetical order' do
        application = Application.create!(
                                          name: "Nate Brown",
                                street_address: "2000 35th Avenue",
                                          city: "Denver",
                                         state: "CO",
                                           zip: "90210",
                                        status: "Pending"
                                            )

        @pet_3.applications << application
        @pet_5.applications << application

        expect(Shelter.order_pending_alphabetically).to eq([@shelter_3, @shelter_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '#alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '#shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '#pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '#has_pending_applications?' do
      it 'only produces shelters with pending applications' do
        application = Application.create!(
                                          name: "Nate Brown",
                                street_address: "2000 35th Avenue",
                                          city: "Denver",
                                         state: "CO",
                                           zip: "90210",
                                        status: "Pending"
                                            )

        @pet_3.applications << application

        expect(@shelter_1.has_pending_applications?).to eq(false)
        expect(@shelter_3.has_pending_applications?).to eq(true)
      end
    end

    describe '#average_adoptable_pet_age' do
      it 'accurately calculates the average of adoptable pets at a shelter' do
        expect(@shelter_1.average_adoptable_pet_age).to eq(4.0)
        expect(@shelter_3.average_adoptable_pet_age).to eq(8.5)
      end
    end
  end
end
