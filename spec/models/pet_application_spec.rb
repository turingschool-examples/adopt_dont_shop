require 'rails_helper'

RSpec.describe PetApplication, type: :model do 
  describe 'relationships' do 
    it {should belong_to :pet}
    it {should belong_to :application}

  end

  describe 'instance methods' do
    describe '.pet_name' do
      it 'retrieves the name of the pet associated with the pet-application' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        app_1 = Application.create!(name: "Taylor Swift", street_address: "22 Blank Space Ln", city: "Denver", state: "CO", zip_code: 80230, status: "Pending", description: "I love cats")
        pet_app_1 = PetApplication.create(application_id: app_1.id, pet_id: pet_1.id)

        expect(pet_app_1.pet_name).to eq("Mr. Pirate")
      end
    end
  end
end