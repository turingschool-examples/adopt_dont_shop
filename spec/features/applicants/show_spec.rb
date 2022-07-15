require 'rails_helper'

RSpec.describe 'Application Show Page' do
# Application Show Page
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it 'can show applicants information' do
    sally = Applicant.create!(id: 1,
                              name: 'Sally',
                              address: '123 California St, Boulder, CO, 80304', 
                              description: 'I rock!', 
                              status: "Pending")
    pet_1 = Pet.create!(id: 11, adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: .id)
    pet_2 = Pet.create!(id: 12, adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: .id)

    visit '/applicants/:id'

    expect(page).to have_content("Sally")
    expect(page).to have_content("123 California St, Boulder, CO, 80304")
    expect(page).to have_content("I rock!")
    expect(page).to have_content("Nola")
    expect(page).to have_content("Fido")
    expect(page).to have_content("Pending")

    expect(page).to have_selector(:link_or_button, "Nola")
    
  end
end
