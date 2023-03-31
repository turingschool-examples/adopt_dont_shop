require 'rails_helper'

RSpec.describe "/applications/:id" do
  let!(:application_1) { Application.create!(name: "John Doe", address: "123 Main St", city: "Denver", state: "CO", zip: "80202", description: "I love dogs", status: "In Progress") }
  let!(:pet_1) { application_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false) }
  let!(:pet_2) { application_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }

  describe "As a visitor, when I visit an application's show page" do
    it "I can see the name of an applicant, their address, reason they would make a good home for this pet, and the names of all pets that this application is for" do
      vist "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.description)
      expect(page).to have_link(pet_1.name)
      expect(page).to have_content(application_1.status)
    end
  end
end