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
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end

      it '::open_apps' do
        shelter1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
        shelter2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Sky City", rank: 30)
        shelter3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Sky City", rank: 40)
        shelter4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Sky City", rank: 50)
        pet1 = shelter1.pets.create!(name: "Foster", age: 1000, breed: "dog")
        pet2 = shelter2.pets.create!(name: "Bento", age: 23, breed: "dog")
        pet3 = shelter3.pets.create!(name: "Quiggle", age: 555,)
        pet4 = shelter4.pets.create!(name: "Simpleton", age: 80,)
        pet5 = shelter1.pets.create!(name: "Snapchat", age: 799,)
        application1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
        application2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
        application3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
        pet_app_1 = PetApplication.create!(pet_id: pet1.id, application_id: application1.id)
        PetApplication.create!(pet_id: pet3.id, application_id: application1.id)
        pet_app_2 = PetApplication.create!(pet_id: pet5.id, application_id: application1.id)
        PetApplication.create!(pet_id: pet2.id, application_id: application2.id)
        PetApplication.create!(pet_id: pet4.id, application_id: application2.id)
        PetApplication.create!(pet_id: pet4.id, application_id: application3.id)
        pet_app_3 = PetApplication.create!(pet_id: pet5.id, application_id: application3.id, condition: "Approved")

        expect(Shelter.open_apps.all).to eq([shelter4, shelter2])
      end

      it 'reverse_alph method returns shelters in reverse alphabetical order' do
        expect(Shelter.reverse_alph.first.name).to eq(@shelter_2.name)
        expect(Shelter.reverse_alph[1].name).to eq(@shelter_3.name)
        expect(Shelter.reverse_alph[2].name).to eq(@shelter_1.name)
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created.first.name).to eq(@shelter_3.name)
        expect(Shelter.order_by_recently_created[1].name).to eq(@shelter_2.name)
        expect(Shelter.order_by_recently_created[2].name).to eq(@shelter_1.name)
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        # expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
        expect(Shelter.order_by_number_of_pets.first.name).to eq(@shelter_1.name)
        expect(Shelter.order_by_number_of_pets[1].name).to eq(@shelter_3.name)
        expect(Shelter.order_by_number_of_pets[2].name).to eq(@shelter_2.name)
        end
      end
        
    describe '.pending_applications' do
      it 'checks if shelter pets have pending applications' do
        shelter1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
        shelter2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Sky City", rank: 30)
        shelter3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Sky City", rank: 40)
        shelter4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Sky City", rank: 50)
        pet1 = shelter1.pets.create!(name: "Foster", age: 1000, breed: "dog")
        pet2 = shelter2.pets.create!(name: "Bento", age: 23, breed: "dog")
        pet3 = shelter3.pets.create!(name: "Quiggle", age: 555,)
        pet4 = shelter4.pets.create!(name: "Simpleton", age: 80,)
        pet5 = shelter1.pets.create!(name: "Snapchat", age: 799,)
        application1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
        application2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
        application3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
        pet_app_1 = PetApplication.create!(pet_id: pet1.id, application_id: application1.id)
        PetApplication.create!(pet_id: pet3.id, application_id: application1.id)
        pet_app_2 = PetApplication.create!(pet_id: pet5.id, application_id: application1.id)
        PetApplication.create!(pet_id: pet2.id, application_id: application2.id)
        PetApplication.create!(pet_id: pet4.id, application_id: application2.id)
        PetApplication.create!(pet_id: pet4.id, application_id: application3.id)
        pet_app_3 = PetApplication.create!(pet_id: pet5.id, application_id: application3.id, condition: "Approved")

        expect(shelter1.pending_pet_applications).to eq([pet1, pet5])
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

    describe '.count_adopted_pets' do
      it 'returns number of pets that have been adopted' do
        shelter1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
        shelter2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Sky City", rank: 30)
        shelter3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Sky City", rank: 40)
        shelter4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Sky City", rank: 50)
        pet1 = shelter1.pets.create!(name: "Foster", age: 1000, breed: "dog", adoptable: false)
        pet2 = shelter2.pets.create!(name: "Bento", age: 23, breed: "dog", adoptable: false)
        pet3 = shelter3.pets.create!(name: "Quiggle", age: 555, adoptable: false)
        pet4 = shelter4.pets.create!(name: "Simpleton", age: 80, adoptable: false)
        pet5 = shelter1.pets.create!(name: "Snapchat", age: 799, adoptable: false)
        application1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals", status: "Approved")
        application2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
        application3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
        pet_app_1 = PetApplication.create!(pet_id: pet1.id, application_id: application1.id, condition: "Approved")
        pet_app_2 = PetApplication.create!(pet_id: pet3.id, application_id: application1.id, condition: "Approved")
        pet_app_3 = PetApplication.create!(pet_id: pet2.id, application_id: application1.id, condition: "Approved")
        PetApplication.create!(pet_id: pet2.id, application_id: application2.id)
        PetApplication.create!(pet_id: pet4.id, application_id: application2.id)
        pet_app_5 = PetApplication.create!(pet_id: pet4.id, application_id: application3.id, condition: "Approved")
        pet_app_6 = PetApplication.create!(pet_id: pet5.id, application_id: application3.id, condition: "Approved")
        
        expect(shelter1.count_adopted_pets).to eq(2)
        expect(shelter2.count_adopted_pets).to eq(1)
        expect(shelter3.count_adopted_pets).to eq(1)
        expect(shelter4.count_adopted_pets).to eq(1)
      end
    end

    describe 'Class Methods' do
      before do
        @shelter_5 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20, street_address: "123 road street", state: "WA", zipcode: "55555")
        @shelter_6 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Literally the Moon", rank: 30, street_address: "345 street avenue", state: "CO", zipcode: "44444")
        @shelter_7 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Death City", rank: 40, street_address: "567 avenue road", state: "NV", zipcode: "33333")
        @shelter_8 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Seattle", rank: 50, street_address: "789 avenue road", state: "HI", zipcode: "22222")
      end

      it "#find_name" do
        expect(Shelter.find_name(@shelter_5.id)).to eq("Taj Mahal for Dogs")
        expect(Shelter.find_name(@shelter_7.id)).to eq("Alexandria for Squirrels")
      end

      it "#find_address" do
        expect(Shelter.find_address(@shelter_5.id)).to eq("123 road street Sky City WA 55555")
        expect(Shelter.find_address(@shelter_7.id)).to eq("567 avenue road Death City NV 33333")
      end

      it "#reverse_alph" do
        expect(Shelter.reverse_alph).to eq([@shelter_6,@shelter_5,@shelter_8,@shelter_2,@shelter_3,@shelter_1,@shelter_7])
      end
    end
  end
end
