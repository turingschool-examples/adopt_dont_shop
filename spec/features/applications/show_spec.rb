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
    
    fill_in("pet_search", with: "Scooby")
    click_button('Search')
    expect('Search').to appear_before('Scooby')
  end

  it 'has a link to adopt a pet after you search for a pet' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet1 = Pet.create(name: 'Scrappy', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = Application.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "In Progress")

    visit "/applications/#{ application1.id }"


    fill_in("pet_search", with: "Scrappy")
    click_button('Search')

    expect(page).to have_content('Scrappy')
    expect(page).to have_link('Adopt this pet')
    expect("Scrappy").to appear_before('Adopt this pet')
  end

  it 'lets you add a pet to an application' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet1 = Pet.create(name: 'Scrappy', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = Application.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "In Progress")

    visit "/applications/#{ application1.id }"

    fill_in("pet_search", with: "Scrappy")
    click_button('Search')
    click_link('Adopt this pet')

    expect("Pet(s) applied for:").to appear_before('Scrappy')
    expect('Scrappy').to appear_before('Application Status:')
    expect(application1.pets).to eq([pet1])
  end

  it 'has a link to submit once pets are added to application' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "In Progress")

    visit "/applications/#{ application1.id }"

    fill_in("applicant_argument", with: "Caring and loving dog home")
    click_button("Submit Application")
    save_and_open_page
    expect(current_path).to eq("/applications/#{ application1.id }")
    expect(page).to have_content("Pending")
    expect("Applicants reason:").to appear_before("Caring and loving")
    expect(page).to_not have_content("Search")
    expect(page).to_not have_content("Submit Application")
  end
end




