require 'rails_helper'

RSpec.describe 'the applications show page' do
  let(:application) { Application.create!(name: 'Debbie Yang', street_address: '1234 dog way', city: "San Francisco", state: 'CA', zip_code: 66012, description: 'I love dogs') }
  let(:shelter_1) { Shelter.create!(foster_program: true, name: 'DogsBySeth', city: 'Denver', rank: 1) }
  let(:pet_1) { shelter_1.pets.create!(adoptable: true, age: 3, breed: 'Yorkie', name: 'Pickle') }
  let(:pet_2) { shelter_1.pets.create!(adoptable: true, age: 5, breed: 'German Shephard', name: 'Brownie') }

  it "shows an application and all it's attributes" do
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.application_status)
  end

  it "can search for pets" do
    visit "applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to_not have_content(pet_1.name)

    fill_in :pet_name, with: pet_1.name
    click_button "Submit"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet_1.name)
  end

  it "can add a pet to application that links to that pet's show page" do
    visit "applications/#{application.id}"
    fill_in :pet_name, with: pet_1.name
    click_button "Submit"

    expect(page).to have_content(pet_1.name)

    within("##{pet_1.id}")
    click_button "Adopt this Pet"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet_1.name)
    expect(pet_1.name).to appear_before("Submit")
      # save_and_open_page
    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
