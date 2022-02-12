require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the application and all its attributes' do
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", description: "Lover of dogs and avid poo-picker-upper.", status: "In Progress")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id, application_id: application.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id, application_id: application.id)

    visit "/applications/#{application.id}"
    
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(shelter.name)
  end
  
  it 'can search for pets for an application' do 
    application = Application.create(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", description: "Lover of dogs and avid poo-picker-upper.")    
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 4, breed: 'Husky', name: 'Bruce', shelter_id: shelter.id, application_id: application.id)
  
    visit "/applications/#{application.id}"

    expect(page).to have_content("In Progress")
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'Add a Pet to this Application', with: "Scooby"
    expect(page).to have_button("Search")

    click_button("Search")
    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content("Scooby")
    expect("In Progress").to appear_before("Scooby")
  end
end 