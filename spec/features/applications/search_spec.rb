require 'rails_helper'

RSpec.describe 'search' do
  let!(:shelter) { Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:pet) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }
  it 'can search for a pet and display it on the page' do
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    visit "/applications/#{application.id}"
    # save_and_open_page

    expect(page).to have_content('search by Pets:')

    fill_in 'search', with: 'Scooby'
    click_button('Add a Pet to this Application')
    expect(page).to have_content('Scooby')
  end

  
end