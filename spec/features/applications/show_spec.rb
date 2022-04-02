require 'rails_helper'

RSpec.describe 'the application show page' do
  it 'shows the application attributes' do
    furry_friends = Shelter.create!(name: "Furry Friends", foster_program: true, city: "Denver", rank: "2")

    olive = furry_friends.pets.create!(name: "Olive", age: 2, breed: "dog", adoptable: true)

    application_4 = Application.create!(name: "Marky Mark", street_address: "678 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")

    pet_application_5 = PetApplication.create!(pet_id: olive.id, application_id: application_4.id)

    visit "/applications/#{application_4.id}"

    expect(page).to have_content(application_4.name)
    expect(page).to have_content(application_4.street_address)
    expect(page).to have_content(application_4.city)
    expect(page).to have_content(application_4.zip_code)
    expect(page).to have_content(application_4.state)
    expect(page).to have_content(application_4.status)
    expect(page).to have_link("#{olive.name}")

    # click_link("/pets/#{pet.id}")
    # expect(current_path).to eq("/pets/#{olive.id}")
  end
  it 'links to the pets show page' do
    furry_friends = Shelter.create!(name: "Furry Friends", foster_program: true, city: "Denver", rank: "2")

    olive = furry_friends.pets.create!(name: "Olive", age: 2, breed: "dog", adoptable: true)

    application_4 = Application.create!(name: "Marky Mark", street_address: "678 I Way", city: "Richmond", zip_code: 23229, state: "VA", description: "Awaiting Information", status: "In progress")

    pet_application_5 = PetApplication.create!(pet_id: olive.id, application_id: application_4.id)

    visit "/applications/#{application_4.id}"

    click_link("#{olive.name}")
    expect(current_path).to eq("/pets/#{olive.id}")
  end
end
