require 'rails_helper'

RSpec.describe 'the application show' do
  it 'can list application information' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    application = Application.create!(name: 'Jim Jimmerson', address: '123 Fake st, Denver, CO 90210', good_home: 'I love animals!',  application_status: 'In Progress')
    pet1 = application.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = application.pets.create(name: 'Mia', age: 3, breed: 'cat', adoptable: true, shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.good_home)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(application.application_status)
  end
end
  # As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"