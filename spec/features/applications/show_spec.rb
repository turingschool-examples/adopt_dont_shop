require 'rails_helper'

# As a visitor
# When I visit an applications show page
# Then I can see the following:
#
# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe 'application show page', type: :feature do
  it 'shows applications attributes' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 })
    derek.pets << pet_1
    derek.pets << pet_2

    visit "applications/#{derek.id}"

    within '.app' do
      expect(page).to have_content("Applicant name: #{derek.name}")
      expect(page).to have_content("Why they're adopting: #{derek.description}")
      expect(page).to have_content("Application Status: #{derek.status}")
      expect(page).to have_content("Address: #{derek.address["street"]} #{derek.address["city"]} #{derek.address["state"]} #{derek.address["zip"]}")
    end
  end

  it 'shows pets attached to applcation' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 })
    derek.pets << pet_1
    derek.pets << pet_2
    visit "/applications/#{derek.id}"
    
    within '.pets' do

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)

      click_link (pet_1.name)

      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
  end
end
