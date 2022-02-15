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
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @simba = @shelter_1.pets.create(name: 'simba', age:12, breed: 'Doberman', adoptable: true)

    @application_1 = Application.create(name: "Jose Molina", street_address: "345 Colfax Ave", city: "Denver", state: "CO", zip_code: "80203", description: "I want a cat")
  end

  it 'visits application show page and sees attributtes' do
    # application = Application.create!(name: 'Ana Maria', street_address: '8900 Colfax Ave', city: 'Denver', state: 'CO', zip_code: '80204', status: 'pending', description: 'Looking for a cat')
    #application = Application.last
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@application_1.description)

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

it 'has a section on the page with input to search for pets' do
  # shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  # pet_1 = shelter_1.pets.create(name: 'simba', age:12, breed: 'Doberman', adoptable: true)
  #
  # application_2 = Application.last
  visit "/applications/#{@application_1.id}"

  expect(page).to have_content("Search for pets by name")
  fill_in :search, with: "simba"

  click_on "Submit"
  expect(current_path).to eq("/applications/#{@application_1.id}")
  expect(page).to have_content("simba")

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

  # it 'has a section on the page with input to search for pets' do
  #   shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = shelter_1.pets.create(name: 'simba', age:12, breed: 'Doberman', adoptable: true)
  #
  #   application_2 = Application.last
  #   visit "/applications/#{application_2 .id}"
  #
  #   expect(page).to have_button("Add a Pet to this application")
  #   fill_in "Search", with: "simba"
  #
  #   click_button "Add a Pet to this application"
  #   expect(current_path).to eq("/applications/#{application_2.id}")
  #
  #   expect(page).to have_content(pet_1.name)
  # end


    # Add a Pet to an Application
    #
    # As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application

  it 'can add pet to application' do
    application_1 = Application.create!(name: "Jose Molina", street_address: "123 Federal", city: "Denver", state: "CO", zip_code: "80203", description: "I want to give an animal a happy home")
    application_2 = Application.create!(name: "Ana Lopez", street_address: "3333 Colfax", city: "Denver", state: "CO", zip_code: "80204", description: "I am good animals ")
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = application_1.pets.create!(name: 'Simba', age:12, breed: 'Doberman', adoptable: true, shelter: shelter_1)
    pet_2 = application_2.pets.create!(name: 'Jack', age:2, breed: 'Mutt', adoptable: true, shelter: shelter_1)
    pet_3 = application_2.pets.create!(name: 'Terry', age:6, breed: 'Lab', adoptable: true, shelter: shelter_1)
    firulais = Pet.create!(name: 'Firulais', age:1, breed: 'Lab', adoptable: true, shelter: shelter_1)


    visit "/applications/#{application_1.id}"

    expect(page).to have_content("Search for pets by name")
    fill_in :search, with: "simba"
    
    click_on "Submit"

    click_button "Adopt this pet"

    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(application_1.pets.first).to eq(pet_1)
  end
end
