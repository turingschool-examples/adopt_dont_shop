require 'rails_helper'

RSpec.describe 'show page' do
  # Application Show Page
  #
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  describe 'Appication page content' do
    it "shows the application and pet attributes/links" do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id, )
      ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id, )

      visit "/applications/#{application.id}"

      expect(page).to have_content("Name: #{application.name}")
      expect(page).to have_content("Address: #{application.address}")
      expect(page).to have_content("City: #{application.city}")
      expect(page).to have_content("State: #{application.state}")
      expect(page).to have_content("Zipcode: #{application.zip_code}")
      expect(page).to have_content("Description: #{application.description}")

      expect(page).to have_link("Pet Name: #{pet_1.name}")
      expect(page).to have_link("Pet Name: #{pet_2.name}")

      expect(page).to have_content("Application Status: #{application.status}")

      click_on "#{pet_1.name}"

      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
  end
end
