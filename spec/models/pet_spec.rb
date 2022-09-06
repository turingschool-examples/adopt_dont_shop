require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end
  
  describe 'many-to-many relationship with pets' do
    it { should have_many(:pet_applications)}
    it { should have_many(:applications).through(:pet_applications) }
  end

  before(:each) do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )
    @app2 = Application.create!(fname: 'John', lname: 'Smith', street_address: '1234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsable', status: "Pending" )

    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)


    @app2.pets << @pet_1
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end
    
    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
    
    describe '#avg_age' do
      it 'returns average age of adoptable pets' do
        expect(Pet.avg_age).to eq(4.0)
      end
    end

    describe '#count_adoptable' do
      it 'returns count of adoptable pets' do
        expect(Pet.count_adoptable).to eq(2)
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end

  describe 'class methods' do
    describe '#add_pet_status' do
      it 'does a thing' do
        expect(Pet.add_pet_status(Application.itself).first).to eq(@pet_1)
      end
    end

    describe '#pending_apps' do
      it 'returns shelters assoctiated to pets with pending applications' do
        pend = Pet.pending_apps
        expect(pend[0].name).to eq("Aurora shelter")
      end

      it 'returns shelters in alpha order' do
        @app3 = Application.create!(fname: 'ohn', lname: 'mith', street_address: '234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsae', status: "Pending" )
        @app4 = Application.create!(fname: 'hn', lname: 'ith', street_address: '34 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsa', status: "Pending" )

        @pet_4 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
        @pet_5 = @shelter_3.pets.create(name: 'Banann', breed: 'doll', age: 7, adoptable: true)
        @app3.pets << @pet_4
        @app4.pets << @pet_5


        expect(Pet.pending_apps[0].name).to eq("Aurora shelter")
        expect(Pet.pending_apps[1].name).to eq('Fancy pets of Colorado')
        expect(Pet.pending_apps[2].name).to eq('RGV animal shelter')
      end
    end

    describe '#pet_app_pending' do
      it 'returns pets associated with a shelter with pending applications' do

        pend = Pet.pet_app_pending(@shelter_1.id)

        expect(pend[0].pet_name).to eq("Mr. Pirate")
        expect(pend[0].application_status).to eq("Pending")
      end
    end
  end
end
