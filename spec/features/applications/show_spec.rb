require 'rails_helper'

RSpec.describe 'the application show page' do
  it 'shows name of applicant' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', status: "Pending")

    visit "/applications/#{application1.id}"

    expect(page).to have_content(application1.name)
    expect(page).to have_content(application1.street)
    expect(page).to have_content(application1.city)
    expect(page).to have_content(application1.state)
    expect(page).to have_content(application1.zip)
    expect(page).to have_content(application1.applicant_argument)
    expect(page).to have_content(application1.pets.first.name)
    expect(page).to have_content(application1.status)
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