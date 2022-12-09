require 'rails_helper'

RSpec.describe 'applications create page' do
  it 'has a link to a new application on the pet index page' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/pets"

    click_link "Start an Application"

    expect(current_path).to eq("/applications/new")
  end

  it 'creates a new application' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit '/applications/new'

    fill_in('Name', with: 'Sandy')
    fill_in('Street', with: '123 Main St')
    fill_in('City', with: 'Smryna')
    fill_in('State', with: 'Tennessee')
    fill_in('Zip', with: '37129')
    fill_in('Applicant argument', with: 'My kids need a dog')

    click_button('Submit')
   
    expect(current_path).to eq("/applications/#{application1.id + 1}")
    expect(page).to have_content("Sandy")
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("Smryna")
    expect(page).to have_content("Tennessee")
    expect(page).to have_content("37129")
    expect(page).to have_content("My kids need a dog")
    expect(page).to have_content("In Progress")
  end
end