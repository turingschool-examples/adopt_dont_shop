require 'rails_helper'

RSpec.describe PetPetition do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:petition) }
  end

  describe 'class methods' do
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
    describe '.associated_pets' do
      it 'collects all pets associated with a petition' do
        expect(PetPetition.associated_pets(@ted.id)).to eq([@pet_1, @pet_2])
      end
    end

    describe '.select' do
      it 'returns a specific pet_petition based on inputs' do
        expect(PetPetition.select(@pet_1.id, @ted.id)).to eq @pet_petition_1
      end
    end

  end
end
