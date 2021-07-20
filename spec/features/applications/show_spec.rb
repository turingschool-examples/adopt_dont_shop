require 'rails_helper'

RSpec.describe 'applications' do
  before(:each) do
    @application = Application.create!(name: 'Jason Knoll',
                                      street_address: '1234 N. Something St',
                                      city: "Scottsdale",
                                      state: "AZ",
                                      zip_code: "99999",
                                      description: "",
                                      status: "In Progress")
  end

  it 'shows specifications of certain applicant' do
    # When I visit an applications show page
    # Then I can see the following:
    #
    # Name of the Applicant
    # Full Address of the Applicant including street address, city, state, and zip code
    # Description of why the applicant says they'd be a good home for this pet(s)
    # names of all pets that this application is for (all names of pets should be links to their show page)
    # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street_address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip_code)
  end

  it 'seaches pets for an applicaiton' do
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search

    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    fill_in :search, with: "Lobster"
    click_button "Submit"

    expect(current_path).to eq "/applications/#{@application.id}"
    expect(page).to have_content("doberman")
    expect(page).to have_content("Adoptable")

    expect(page).to_not have_content("sphynx")
  end

  it "add a pet to an application" do
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application
  shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
  pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

  visit "/applications/#{@application.id}"
  fill_in :search, with: "Lobster"
  click_button "Submit"


  click_button "Adopt this Pet"
  save_and_open_page

  expect(page).to have_content("Lobster")
  end
end
