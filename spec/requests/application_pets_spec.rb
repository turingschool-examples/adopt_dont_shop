require 'rails_helper'

RSpec.describe "ApplicationPets", type: :request do
  before :each do
    @app = Application.create!(name: 'Oz', street_address: '3504 Gloria Ave.', city: 'Chicago', state: 'IL', zip_code: '80206', description: 'cool dude', status: 'In Progress')
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @app.pets << @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @app.pets << @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @app.pets << @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: 'Pesto', breed: 'ragdoll', age: 3, adoptable: true)
    @app_pets = ApplicationPet.create!(application_id: @app.id, pet_id: @pet_4.id)
  end

  describe "POST /create" do
    it "returns http success" do
      post "/application_pets/create?application_id=#{@app.id}&pet_id=#{@pet_4.id}"
      
      within('Pesto') do
        expect(page).to have_content("Pesto")
      end
    end
  end
end
