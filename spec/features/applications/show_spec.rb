require 'rails_helper'

RSpec.describe 'application show page' do
  it 'displays application show page and all the attributes' do
    shelter = Shelter.create!(name:'Boise Shelter', city: 'Boise', foster_program: false, rank: 7)
    pet_1 = Pet.create!(adoptable: true, age: 2, breed: 'Bulldog', name: 'Butch', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'German Shpherd', name: 'Sandy', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: false, age: 4, breed: 'Poodle', name: 'Zinnia', shelter_id: shelter.id)
    application = Application.create!(name: "Taylor Hammond", street_address: "5234 Broadway Avenue", city: "Dallas", state: "Texas", zip_code: '86754', description: "I am very good person", status: "In Progress")

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.status)
  end

  it 'has text box to search for pet by name' do
    shelter = Shelter.create!(name:'Boise Shelter', city: 'Boise', foster_program: false, rank: 7)
    pet_1 = Pet.create!(adoptable: true, age: 2, breed: 'Bulldog', name: 'Butch', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'German Shpherd', name: 'Sandy', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: false, age: 4, breed: 'Poodle', name: 'Zinnia', shelter_id: shelter.id)
    application = Application.create!(name: "Taylor Hammond", street_address: "5234 Broadway Avenue", city: "Dallas", state: "Texas", zip_code: '86754', description: "I am very good person", status: "In Progress")

    visit "/applications/#{application.id}"

    expect(page).to have_content("Search Adoptable Pets")
    expect(page).to have_button("Search")
  end

  it 'lists partial matches from search' do
    shelter = Shelter.create!(name:'Boise Shelter', city: 'Boise', foster_program: false, rank: 7)
    pet_1 = Pet.create!(adoptable: true, age: 2, breed: 'Bulldog', name: 'Butch', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'German Shpherd', name: 'Sandy', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: false, age: 4, breed: 'Poodle', name: 'Zinnia', shelter_id: shelter.id)
    application = Application.create!(name: "Taylor Hammond", street_address: "5234 Broadway Avenue", city: "Dallas", state: "Texas", zip_code: '86754', description: "I am very good person", status: "In Progress")

    visit "/applications/#{application.id}"

    fill_in 'search', with: "tc"
    click_on "commit"

    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_3.name)
    expect(page).to_not have_content(pet_2.name)
  end

  it ' can add pet to application' do
    shelter = Shelter.create!(name:'Boise Shelter', city: 'Boise', foster_program: false, rank: 7)
    pet_1 = Pet.create!(adoptable: true, age: 2, breed: 'Bulldog', name: 'Butch', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'German Shpherd', name: 'Sandy', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: false, age: 4, breed: 'Poodle', name: 'Zinnia', shelter_id: shelter.id)
    application = Application.create!(name: "Taylor Hammond", street_address: "5234 Broadway Avenue", city: "Dallas", state: "Texas", zip_code: '86754', description: "I am very good person", status: "In Progress")

    visit "/applications/#{application.id}"
    expect(page).to_not have_content(pet_1.name)

    fill_in 'search', with: "tc"
    click_on "commit"

    click_on("Adopt this Pet")

    expect(page).to have_content(pet_1.name)
  end

  it 'can submit application when pet is added'
end
