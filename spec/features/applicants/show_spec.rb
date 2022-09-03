require 'rails_helper'

RSpec.describe Applicant do
  describe 'applicant show page' do
    it 'shows applicants information' do
      shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      app1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
                              city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs")
      # app2 = Applicant.create!(name: "Cydney Whitemon", street_address: "124 S Way Avenue",
      #                         city: "Denver", state: "CO", zip_code: "80019", description: "Dogs Like Me")
      pet1 = Pet.create!(adoptable: true, age: 6, breed: "Catahoula Leopard Dog", name: "Rosy", shelter_id: shelter1.id)
      pet2 = Pet.create!(adoptable: true, age: 4, breed: "Dobermann", name: "Lundy", shelter_id: shelter1.id)

      pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: app1.id)
      pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: app1.id)

      visit "/applicants/#{app1.id}"

      within "#applicant-#{app1.id}" do
        expect(page).to have_content("Name:\nBilly Wahl")
        expect(page).to have_content("Address:\n123 S Street Way, Denver, CO 80123")
        expect(page).to have_content("Why I would make a good home:\nI Like Dogs")
        expect(page).to have_content("Pets Applied For:\nRosy Lundy")
        expect(page).to have_content("Application Status: In Progress")
      end
    end

    it 'can submit an application' do
      shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      app1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
        city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs")

      pet1 = Pet.create!(adoptable: true, age: 6, breed: "Catahoula Leopard Dog", name: "Rosy", shelter_id: shelter1.id)
      pet2 = Pet.create!(adoptable: true, age: 4, breed: "Dobermann", name: "Lundy", shelter_id: shelter1.id)

      visit "/applicants/#{app1.id}"
      expect(page).to_not have_css("#submit")
      expect(page).to have_css("#add_pets")

      pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: app1.id)
      pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: app1.id)

      visit "/applicants/#{app1.id}"

      expect(page).to have_css("#submit")
      expect(page).to have_css("#add_pets")

      within "#submit" do
        expect(page).to have_content("Why would I make a good owner for these pet(s)?")

        fill_in :description, with: "I love having to pretty bestfriends"

        click_button "Submit"
        expect(current_path).to eq("/applicants/#{app1.id}")

        app1_update = Applicant.find(app1.id)

        expect(app1_update.description).to eq("I love having to pretty bestfriends")
        expect(app1_update.status).to eq("Pending")
      end
      expect(page).to_not have_css("#add_pets")
      expect(page).to_not have_css("#submit")

    end
  end
end