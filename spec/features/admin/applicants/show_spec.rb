require 'rails_helper'

RSpec.describe Applicant do
  describe 'Admin Applicant Show Page' do
    it 'for every pet i see a button to approve that application for that pet' do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      
      @app_1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
        city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs", status: 'Pending')
  
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      pet_app1 = PetApplicant.create!(pet_id: @pet_1.id, applicant_id: @app_1.id)
      pet_app2 = PetApplicant.create!(pet_id: @pet_2.id, applicant_id: @app_1.id)

      visit "/admin/applicants/#{@app_1.id}"

      within ".pets" do
        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Accept Pet Application")
          click_button "Accept Pet Application"
          expect(current_path).to eq("/admin/applicants/#{@app_1.id}")
          expect(page).to_not have_button("Accept Pet Application")
          expect(page).to have_content("Accepted")
        end
      end
    end

    it 'for every pet i see a button to reject that application for that pet' do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      
      @app_1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
        city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs", status: 'Pending')
  
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      pet_app1 = PetApplicant.create!(pet_id: @pet_1.id, applicant_id: @app_1.id)
      pet_app2 = PetApplicant.create!(pet_id: @pet_2.id, applicant_id: @app_1.id)

      visit "/admin/applicants/#{@app_1.id}"

      within ".pets" do
        within "#pet-#{@pet_1.id}" do
          expect(page).to have_button("Reject Pet Application")
          click_button "Reject Pet Application"
          expect(current_path).to eq("/admin/applicants/#{@app_1.id}")
          expect(page).to_not have_button("Accept Pet Application")
          expect(page).to_not have_button("Reject Pet Application")
          expect(page).to have_content("Rejected")
          expect(page).to_not have_content("Accepted")
        end
      end
    end

  end
end