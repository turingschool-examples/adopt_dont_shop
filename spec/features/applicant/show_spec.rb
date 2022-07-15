require 'rails_helper'

# Application Show Page
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'the applicant show page' do 
  
  it 'shows the applicant and their attributes' do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: 12345,
                                  description: 'I have a big yard and work from home.',
                                  application_status: 'In Progress'
                                )
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"

    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.full_address)
    expect(page).to have_content(applicant.description)
    expect(page).to have_content(applicant.application_status)
    
  end

  
end
