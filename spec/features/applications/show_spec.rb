require 'rails_helper'

RSpec.describe 'the application show page' do
  it 'shows name of applicant' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/applications/#{application1.id}"

    expect(page).to have_content(application1.name)
    expect(page).to have_content(application1.street)
    expect(page).to have_content(application1.city)
    expect(page).to have_content(application1.state)
    expect(page).to have_content(application1.zip)
    expect(page).to have_content(application1.applicant_argument)
    expect(page).to have_content(application1.pets.first.name)
    expect(page).to have_content(application1.app_status)
  end

  it 'has a pet search field for in progress applications' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet1 = Pet.create(name: 'Scrappy', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = Application.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "In Progress")

    visit "/applications/#{ application1.id }"

    expect(page).to have_content("Add a Pet to this Application")
    
    fill_in("pet_search", with: "scooby")
    click_button('Search')
    expect(current_path).to eq("/applications/#{ application1.id }")
    expect('Search').to appear_before('Scooby')
  end
end


# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search