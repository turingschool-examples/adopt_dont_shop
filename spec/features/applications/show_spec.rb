# As a visitor
# When I visit an applications show page
# Then I can see the following:

# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe Application, type: :feature do
  let!(:application) { Application.create!(
        human_name: "Brad Pitt",
        description: "Very rich, multiple homes, ample backyard space.",
        street_address: "123 Hollywood Blvd",
        city: "Los Angeles",
        state: "CA",
        zip: "90210",
        status: "Rejected")}

  let!(:application_2) { Application.create!(
        human_name: "Aziz Ansari",
        description: "Very funny, entertaining to dogs",
        street_address: "777 Lucky Street",
        city: "Seattle",
        state: "WA",
        zip: "98101",
        status: "Pending")}

  let!(:shelter) { Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'Paws and Tails', city: 'San Francisco CA', foster_program: true, rank: 7) }

  let!(:pet_1) { Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucky', shelter_id: shelter.id) }
  let!(:pet_2) { Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id) }
  let!(:pet_3) { Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter_2.id) }
  
  let!(:application_pets) { ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id) }
  let!(:application_pets_2) { ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id) }
  let!(:application_pets_3) { ApplicationPet.create!(application_id: application.id, pet_id: pet_3.id) }
  let!(:application_pets_4) { ApplicationPet.create!(application_id: application_2.id, pet_id: pet_1.id) }
  let!(:application_pets_5) { ApplicationPet.create!(application_id: application_2.id, pet_id: pet_2.id) }
  describe 'application show page' do
    it 'displays the attributes of a single application' do
      visit "/applications/#{application.id}"
      # save_and_open_page
      expect(page).to have_content(application.human_name)
      expect(page).to have_content("123 Hollywood Blvd")
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip)
      expect(page).to have_content(application.status)

      visit "/applications/#{application_2.id}"

      expect(page).to have_content(application_2.human_name)
      expect(page).to have_content("777 Lucky Street")
      expect(page).to have_content(application_2.description)
      expect(page).to have_content(application_2.city)
      expect(page).to have_content(application_2.state)
      expect(page).to have_content(application_2.zip)
      expect(page).to have_content(application_2.status)
    end
    
    it 'displays all pets for which the application is applying' do
      visit "/applications/#{application.id}"
      
      expect(page).to have_content("Animals Applied For")
      expect(page).to have_link("Lucky", href: "/pets/#{pet_1.id}")
      expect(page).to have_link("Lobster", href: "/pets/#{pet_2.id}")
      expect(page).to have_link("Sylvester", href: "/pets/#{pet_3.id}")

      visit "/applications/#{application_2.id}"

      expect(page).to have_link("Lucky", href: "/pets/#{pet_1.id}")
      expect(page).to have_link("Lobster", href: "/pets/#{pet_2.id}")

      expect(page).to_not have_link("Sylvester", href: "/pets/#{pet_3.id}")
    end
  end
end