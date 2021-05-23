

require 'rails_helper'

RSpec.describe 'the application show' do

  # [] done
  #
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

  it "shows the application and all it's attributes" do
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: 'Looking for a pet', status: "Pending" )
    visit "/applications/#{application_one.id}"

    expect(page).to have_content(application_one.name)
    expect(page).to have_content(application_one.address)
    expect(page).to have_content(application_one.description)
    expect(page).to have_content(application_one.status)
  end

  #   [ ] done
  #
  # Searching for Pets for an Application
  #
  # As a visitor
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search

  it "can search for a pet by name" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: 'Looking for a pet', status: "Pending" )
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Jack', shelter_id: shelter.id)
    visit "/applications/#{application_one.id}"

    expect(page).to have_content("Sally Smith")
    expect(page).to have_field(:pet_of_interst_name)

    fill_in( "pet_of_interst_name", with: "Jack")
    click_on("Find")
    
    expect(page).to have_content("Jack")
  end



end
