require 'rails_helper'

RSpec.describe 'show page' do

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

#   As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search
  it "can search for a pet" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id, )
    ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id, )

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a pet to this Application")

      fill_in 'Search', with: "luc"
      click_on('Submit')

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("#{pet_1.name}")
      expect(page).not_to have_content("#{pet_2.name}")
  end
end
