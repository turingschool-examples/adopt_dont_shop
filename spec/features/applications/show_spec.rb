# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the applications show' do
  it 'shows the name and full address of the applicant' do
    applicant_1 = Application.create!(name: 'John Smith', street: '123 Oak Lane', city: 'Anytown', state: 'CO', zip: 12345, description: 'I love dogs', status: 'In Progress')

    visit "/applications/#{applicant_1.id}"

    expect(page).to have_content(applicant_1.name)
    expect(page).to have_content(applicant_1.street)
    expect(page).to have_content(applicant_1.city)
    expect(page).to have_content(applicant_1.state)
    expect(page).to have_content(applicant_1.zip)
    expect(page).to have_content(applicant_1.description)
    expect(page).to have_content(applicant_1.status)
  end

  xit 'shows the names of all the pets that this application is for' do
    applicant_1 = Application.create!(name: 'John Smith', street: '123 Oak Lane', city: 'Anytown', state: 'CO', zip: 12345, description: 'I love dogs', status: 'In Progress')
    shelter_1 = Shelter.create!(foster_program: true, name: 'Good Shelter', city: 'Anytown', rank: 20)
    pet_1 = shelter_1.pets.create!(adoptable: true, age: 5, name: 'Champ')
    # pet_app_1 = pet_1.applicant_1.create!(pet_id: pet_1.id, application_id: applicant_1.id)
    visit "/applications/#{applicant_1.id}"

    expect(current_path).to have_link("Pet",:href=>"/pets/#{pet_1.id}")
  end
end
