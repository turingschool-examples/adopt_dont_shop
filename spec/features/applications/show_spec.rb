# As a visitor
# When I visit an applications show page
# Then I can see the following:

# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the application show' do
  shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
  applicant = Application.create!(name: 'Dawson', 
  street_address: '1234 example ave.', 
  city: 'Denver', 
  state: 'CO',
  zip_code: 12345, 
  reason_for_adoption: "I love dogs",
  pet_id: pet.id,
  status: "In Progress"
  )
  it "shows the visitor the applicant and all of it's attributes" do
    visit "/applications/#{applicant.id}"
    
    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.reason_for_adoption)
    expect(page).to have_content(applicant.pet_id)
    expect(page).to have_content(applicant.status)
  end
end