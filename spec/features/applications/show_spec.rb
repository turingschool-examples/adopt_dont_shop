require 'rails_helper'

# TODO: merge seeds files to make objects in tests consistent

RSpec.describe 'the shelter show' do
  let(:application) { Application.create!(name: 'Debbie', street_address: '1234 dog way', city: "San Francisco", state: 'CA', zip_code: 66012, description: 'I love dogs', application_status: 'Accepted') }
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
    click_button('Submit')

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet_1.name)
  end
end
