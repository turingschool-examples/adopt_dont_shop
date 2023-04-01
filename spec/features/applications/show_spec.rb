require 'rails_helper'

RSpec.describe "/applications/:id" do
  let!(:shelter_1) { Shelter.create!(name: "Dumb Friends League", city: "Denver", foster_program: false, rank: 9) }
  let!(:pet_1) { shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
  let!(:application_1) { Application.create!(name: "John Doe", street_address: "123 Main St", city: "Denver", state: "CO", zip_code: "80202", description: "I love dogs", status: "In Progress") }

  describe "As a visitor, when I visit an application's show page" do
    it "I can see the name of an applicant, their address, reason they would make a good home for this pet, and the names of all pets that this application is for" do
      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.status)
    end

    it "I can search for pets by name and see results" do
      visit "/applications/#{application_1.id}"

      expect(page).to have_content("Add a Pet to this Application")

      fill_in :query, with: "Clawdia"
      click_button "Search"

      expect(page).to have_content(pet_2.name)
    end

    it "There is a button to 'Adopt this Pet' next to each pet" do
      visit "/applications/#{application_1.id}"

      fill_in :query, with: "Clawdia"
      click_button "Search"

      expect(page).to have_button("Adopt this Pet")

      click_button "Adopt this Pet"

      expect(page).to have_link(pet_2.name)
      expect(pet_2.name).to appear_before("Submit Application")
    end

    it "I can submit an application for one or more pets, and add a description on why I would make a good pet owner" do
      visit "/applications/#{application_1.id}"
      fill_in :query, with: "Clawdia"
      click_button "Search"
      click_button "Adopt this Pet"

      expect(page).to have_button("Submit Application")
      expect(page).to have_content("Why would you make a good pet owner?")

      fill_in :description, with: "I love dogs"
      click_button "Submit Application"

      expect(current_path).to eq("/applications/#{application_1.id}")
      expect(page).to have_content("I love dogs")
      expect(page).to have_content("Status: Pending")
      expect(page).to_not have_button("Submit Application")
      expect(page).to_not have_content("Why would you make a good pet owner?")
    end

    it 'does not allow me to submit an application without a pet selected' do
      visit "/applications/#{application_1.id}"

      expect(page).to_not have_button("Submit Application")
      expect(page).to_not have_content("Why would you make a good pet owner?")
    end

    it 'can find results with partial matches' do
      visit "/applications/#{application_1.id}"

      fill_in :query, with: "Mr"
      click_button "Search"

      expect(page).to have_content(pet_1.name)
    end

    it 'can find results with partial matches and case insensitive' do
      visit "/applications/#{application_1.id}"

      fill_in :query, with: "mr"
      click_button "Search"

      expect(page).to have_content(pet_1.name)
    end
  end
end