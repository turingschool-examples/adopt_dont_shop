require 'rails_helper'

RSpec.describe Petition do
  describe 'relationships' do
    it { should have_many(:pet_petitions) }
    it { should have_many(:pets).through(:pet_petitions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  describe 'instance methods' do
    before :each do
      @ted = Petition.create!(name: 'Ted Leo',
                              street_address: '123 Pharmacist Ln',
                              city: 'Phoenix City',
                              state: 'Alabama',
                              zipcode: '12345')
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @pet_petition_1 = PetPetition.create!(petition: @ted, pet: @pet_1)
      @pet_petition_2 = PetPetition.create!(petition: @ted, pet: @pet_2)
    end
    describe '#associated_pet_petitions' do
      it 'returns all associated pet petitions' do
        expect(@ted.associated_pet_petitions).to eq([@pet_petition_1, @pet_petition_2])
      end
    end
  end
end
