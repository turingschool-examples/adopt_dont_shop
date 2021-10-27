require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications) }
    it { should have_many(:applications).through(:pet_applications) }
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
  end

  describe 'class methods' do
    describe '::search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '::adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '#shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe '#approved_for_adoption?' do
      it 'returns false if the pet is not on any applications that are approved' do
        expect(@pet_1.approved_for_adoption?).to eq false
      end

      it 'returns true if the pet is on an application that has been fully approved' do
        application = Application.create(name:        'CatMan',
                                         address:     '123 Main Street',
                                         city:        'Denver',
                                         state:       'CO',
                                         zip:         '80204',
                                         description: 'I WANT ALL THE CATS!',
                                         status:       'Approved'
        )
        application.pets << @pet_1

        expect(@pet_1.approved_for_adoption?).to eq true
      end
    end
  end
end
