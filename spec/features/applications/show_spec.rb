require 'rails_helper'
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
RSpec.describe 'application show page' do

  xit 'visits application show page and sees attributtes' do
    application = Application.create!(name: 'Ana Maria', street_address: '8900 Colfax Ave', city: 'Denver', state: 'CO', zip_code: '80204', status: 'pending', description: 'Looking for a cat')
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.description)

  end

# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

it 'has a text box to filter results by keyword' do
  application_2 = Application.last
  visit "/applications/#{application_2 .id}"

  expect(page).to have_button("Add a Pet to this application")

end

xit 'lists partial matches as search results' do
  shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
  pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
  pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

  visit "/pets"

  fill_in 'Search', with: "Ba"
  click_on("Search")

  expect(page).to have_content(pet_1.name)
  expect(page).to have_content(pet_2.name)
  expect(page).to_not have_content(pet_3.name)
end
end
