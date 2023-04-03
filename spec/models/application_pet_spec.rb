require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do

  let!(:shelter_1) { Shelter.create!(name: "Dumb Friends League", city: "Denver", foster_program: false, rank: 9) }
  let!(:pet_1) { shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
  let!(:application_1) { Application.create!(name: "John Doe", street_address: "123 Main St", city: "Denver", state: "CO", zip_code: "80202", description: "I love dogs", status: "In Progress") }
  let!(:application_2) { Application.create!(name: "Billy Bob", street_address: "123 Main St", city: "Denver", state: "CO", zip_code: "80202", description: "I love cats", status: "In Progress") }
  let!(:application_pets_1) { ApplicationPet.create!(application_id: application_1.id, pet_id: pet_1.id) }
  let!(:application_pets_2) { ApplicationPet.create!(application_id: application_2.id, pet_id: pet_1.id) }

  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  describe 'validations' do
    it { should validate_presence_of(:application_id) }
    it { should validate_presence_of(:pet_id) }
  end

  describe 'class methods' do 
    describe '::approve_all?' do
      it 'checks to see if all pets have an approved status on an application' do
        expect(ApplicationPet.all_approved?).to be(false)
        ApplicationPet.update(status: 'Approved')
        expect(ApplicationPet.all_approved?).to be(true)
      end
    end
  end
end
