require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'instance methods' do
    it 'can sort applications by pending status' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "Richard is a good dog name", status: "Pending")
      application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")

      expect(application_1.pending_app?).to be(true)
    end

    it 'can add a pet to save the application' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "Richard is a good dog name", status: "Pending")
      application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")
      pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)

      application_1.add_pet?(pet_3)
      
      expect(PetApplication.last.pet_id).to eq(pet_3.id)
    end
  end
end
