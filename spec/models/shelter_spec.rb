require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
    it { should have_many(:applications).through(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', street: "123 Main", city: 'Aurora', state: 'CO', zip: "12345", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application1 = @pet_1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    @application2 = @pet_3.applications.create!(name: 'Jerry Rice', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
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

    describe '.pending' do
      it 'returns shelters with pending applications in alphabetical order' do
        shelter4 = Shelter.create!(name: 'AAA Nashville Shelters', city: 'Nashville', foster_program: true, rank: 10)
        pet1 = shelter4.pets.create!(name: 'Mr. Krabs', breed: 'tuxedo shorthair', age: 5, adoptable: false)
        application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

        expect(Shelter.pending).to eq([shelter4, @shelter_1, @shelter_3])
      end
    end
  end

  describe '#sort_reverse_alpha' do
    it 'returns shelters in reverse alphabetical order' do
      expect(Shelter.sort_reverse_alpha).to eq([@shelter_2, @shelter_3, @shelter_1])

      shelter_4 = Shelter.create!(foster_program: true, name: "Zoo Shelter", city: "Seattle", rank: 9)

      expect(Shelter.sort_reverse_alpha).to eq([shelter_4, @shelter_2, @shelter_3, @shelter_1])
    end
  end

  describe '#find_name_and_address' do
    it 'can return the name and address of a shelter' do

      shelter = Shelter.find_name_and_address(@shelter_1.id)
   
      expect(shelter.name).to eq(@shelter_1.name)
      expect(shelter.street).to eq(@shelter_1.street)
      expect(shelter.city).to eq(@shelter_1.city)
      expect(shelter.state).to eq(@shelter_1.state)
      expect(shelter.zip).to eq(@shelter_1.zip)
      
      expect(shelter).to_not respond_to(:rank)
      expect(shelter).to_not respond_to(:foster_program)
      expect(@shelter_1).to respond_to(:rank)
    end
  end
end