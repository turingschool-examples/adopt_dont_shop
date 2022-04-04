require 'rails_helper'

RSpec.describe 'application show page' do
  it "shows the applicants attributes" do
    shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
      pets: Pet.all
    )
    # application_pet_1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)

    click_link "#{pet1.name}"
    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it "allows to add a pet to application" do
    shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    dog = Pet.create!(name: 'Dog', age: 4, breed: 'German', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
    )
    # application_pet_1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    visit "/applications/#{application.id}"
    fill_in 'Pets', with: "Joey"
    click_button "Search"
    expect(page).to have_link("Joey")
    expect(current_path).to eq("/applications/#{application.id}")
  end

  it "has button to add a pet to application for adoption" do
    shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    dog = Pet.create!(name: 'Dog', age: 4, breed: 'German', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
    )
    # application_pet_1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    visit "/applications/#{application.id}"
    fill_in 'Pets', with: "Joey"
    click_button "Search"
    expect(page).to have_link("Joey")
    click_button 'Adopt this Pet'
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Joey")
  end
end
