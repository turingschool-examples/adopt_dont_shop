# [ ] done
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
require 'rails_helper'

RSpec.describe 'Application Show Page' do


  it 'can display application info' do
     app = Application.create!(name: 'Billy', city: 'Denver', street_address: '123 lion st', state: 'CO', zip: 12345, status: "In Progress", description: 'test')
     shelter = Shelter.create!(foster_program: true,
      name: 'Bundle park',
      city: 'Denver',
      rank: 3
    )
     dog1 = shelter.pets.create!(adoptable: true,
        age: 2,
        breed: 'yes',
        name: 'Bob'
      )
    dog2 = shelter.pets.create!(adoptable: true,
       age: 2,
       breed: 'yes',
       name: 'Billy'
     )

    PetApplication.create!(pet: dog1, application: app)
    PetApplication.create!(pet: dog2, application: app)

    visit "/applications/#{app.id}"

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.street_address)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
    expect(page).to have_content(dog1.name)
    expect(page).to have_content(dog2.name)
    expect(page).to have_content(app.description)
    expect(page).to have_content(app.status)
  end

  it 'can search for pets' do
    app = Application.create!(name: 'Billy',
      city: 'Denver',
      street_address: '123 lion st',
      state: 'CO',
      zip: 12345,
      status: 'In Progress'
    )
    shelter = Shelter.create!(foster_program: true,
     name: 'Bundle park',
     city: 'Denver',
     rank: 3
   )
    dog1 = shelter.pets.create!(adoptable: true,
       age: 2,
       breed: 'yes',
       name: 'Bob'
     )
   dog2 = shelter.pets.create!(adoptable: true,
      age: 2,
      breed: 'yes',
      name: 'Billy'
    )

    visit "/applications/#{app.id}"

    expect(page).to have_content('Add a Pet to this Application')
    expect(page).to_not have_content(dog1.name)
    expect(page).to have_content('In Progress') # And that application has not been submitted. Search bar contingent on application status?

    fill_in 'search', with: dog1.name
    click_button 'submit'

    expect(current_path).to eq("/applications/#{app.id}")
    expect(page).to have_content(dog1.name)
    expect(page).to_not have_content(dog2.name)
  end
end
