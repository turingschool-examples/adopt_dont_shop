# As a visitor
# When I visit an applications show page
# Then I can see the following:
#
# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
require 'rails_helper'

RSpec.describe 'pet application show' do
  it 'shows the applicant details' do
    app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                 reason: 'Pet friendly, loving home looking for a companion')

    visit "/applications/#{app.id}"

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.street)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
    expect(page).to have_content(app.reason)
  end

  it 'shows pets tied to application' do
    app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                 reason: 'Pet friendly, loving home looking for a companion')

    shelter = Shelter.create!(foster_program: true, name: 'Phoenix Pet Friends', city: 'Phoenix, AZ', rank: 2)

    cat = app.pets.create!(adoptable: true, age: 8, breed: 'Bombay', name: 'Moxie', shelter_id: shelter.id)
    dog = app.pets.create!(adoptable: true, age: 4, breed: 'Mutt', name: 'Daisy', shelter_id: shelter.id)

    visit "/applications/#{app.id}"

    expect(page).to have_content(cat.name)
    expect(page).to have_content(dog.name)
  end
end
