require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter)}
    it { should have_many(:application_pets)}
    it { should have_many(:applications).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application_1 = Application.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      description: "I like pets",
      status: "Pending"
  )
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
    #User Story 10/11
    describe '#filter_by_name' do
      it 'filters pets by name and partial matches and is case insensitive' do
        params_1 = {"utf8"=>"✓", :name=>"lawd", "commit"=>"Search", "controller"=>"applications", "action"=>"show", "id"=>"31"}
        pets_1 = Pet.filter_by_name(params_1,@application_1)
        expect(pets_1.first).to eq(@pet_2)

        params_2 = {"utf8"=>"✓", :name=>"Pir", "commit"=>"Search", "controller"=>"applications", "action"=>"show", "id"=>"31"}
        pets_2 = Pet.filter_by_name(params_2,@application_1)
        expect(pets_2.first).to eq(@pet_1)

        params_3 = {"utf8"=>"✓", :name=>"aNN", "commit"=>"Search", "controller"=>"applications", "action"=>"show", "id"=>"31"}
        pets_3 = Pet.filter_by_name(params_3,@application_1)
        expect(pets_3.first).to eq(@pet_3)
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
end
