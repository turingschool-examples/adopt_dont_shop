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

    describe '#order_reverse_alphabetically' do
      it 'orders the shelters reverse-alphabetically' do
        expect(Shelter.order_reverse_alphabetically).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe '#with_pending_applications' do
      it 'returns the shelters with pets that are associated with a pending application' do
        pet_5 = @shelter_2.pets.create(name: 'Brian', breed: 'German Shepard', age: 3, adoptable: true)
        application_1 = @pet_1.applications.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'Pending')
        application_2 = pet_5.applications.create!(name: 'James', address: '1259 N Clarkson St.', city: 'Denver', state: 'CO', zipcode: '80218', description: "Love dogs.", status: 'Pending')
        application_3 = @pet_3.applications.create!(name: 'Ian', address: '4690 S Garrison St.', city: 'Denver', state: 'CO', zipcode: '80123', description: "Love dogs.", status: 'In-progress')

        expect(Shelter.with_pending_applications).to eq([@shelter_1, @shelter_2])
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

    describe '.adoptable_pets_average_age' do
      it 'returns the average age of the shelters adoptable pets' do
        expect(@shelter_1.adoptable_pets_average_age).to eq(4)
      end
    end

    describe '.adoptable_pet_count' do
      it 'returns the number of adoptable pets at the given shelter' do
        expect(@shelter_1.adoptable_pet_count).to eq(2)
      end
    end

    describe '.action_required_pets' do
      it 'returns the pets (not approved or rejected) from applications that are pending' do
        application_1 = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'Pending')
        shelter_4 = Shelter.create(name: 'ABC shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_5 = application_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_4.id)
        pet_6 = application_1.pets.create(name: 'Mr. P', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_4.id)
        pet_7 = application_1.pets.create(name: 'Mr. Te', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: shelter_4.id)
        ApplicationPet.where(pet: pet_5, application: application_1).first.update(status: :approved)
        ApplicationPet.where(pet: pet_6, application: application_1).first.update(status: :rejected)
        expect(shelter_4.action_required_pets.count).to eq(1)
      end
    end

    describe '.adopted_pet_count' do
      it 'returns the number of adoptable pets at the given shelter' do
        expect(@shelter_1.adopted_pet_count).to eq(1)
      end
    end

    describe '.make_address_readable' do
      it 'returns a single string of the full address of the shelter' do
        shelter_5 = Shelter.create!(name: 'Iron Maiden Animal Shelter', address: "22 Acacia Ave.", city: "New York", state: "NY", zip_code: "10105", foster_program: false, rank: 8)

        expect(shelter_5.make_address_readable).to eq("22 Acacia Ave. New York, NY 10105")
      end
    end
  end
end
