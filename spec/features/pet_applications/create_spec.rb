#   As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application
require 'rails_helper'

RSpec.describe 'PetApplication creation' do
  it 'contains a button to add a pet to an application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    
    visit "/applications/#{application.id}"
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lobster', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Kurby', shelter_id: shelter.id)
    fill_in :query, with: 'Lobster'
    click_button 'Search'
    fill_in :query, with: 'Kurby'
    click_button 'Search'

    expect(page).to have_button("Adopt this pet")

    within "div##{pet_1.id}" do
      click_button 'Adopt this pet'
    end

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pets Added to Application:")
    expect(page).to have_link("Kurby")

    click_link("Kurby")
    expect(current_path).to eq("/pets/#{pet_2.id}")
  end
end