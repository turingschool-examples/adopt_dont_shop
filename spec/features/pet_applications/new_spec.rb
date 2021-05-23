require 'rails_helper'

RSpec.describe 'new pet application' do
  it 'wont go past incomplete applications' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    # applicant = PetApplication.create!(name: "Alex", street: "123 Dutch rd", city: "East Brunswick", state: "New Jersey", zip: "08816", reason: "I'm awesome", status: "Pending")
    pet_application = PetApplication.last

    visit "/pet_applications/new"

    expect(page).to have_content("New Application")
    expect(page).to have_content("Name")
    expect(page).to have_content("Street")
    expect(page).to have_button("Save")


    fill_in :name, with: "Alex"
    # fill_in :street, with: "123 Dutch"
    # fill_in :city, with: "Denver"
    # fill_in :state, with: "Colorado"
    # fill_in :zip, with: "80226"
    fill_in :reason, with: "Because animals are great"
    expect(page).to have_button("Save")
    click_button "Save"
    # expect(current_path).to eq("/pet_applications/new")
    expect(page).to have_content("New Application")

    fill_in :name, with: "Alex"
    # fill_in :street, with: "123 Dutch"
    # fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80226"
    fill_in :reason, with: "Because animals are great"
    expect(page).to have_button("Save")
    click_button "Save"
    expect(current_path).to eq("/pet_applications/new")
    expect(page).to have_content("New Application")

    fill_in :name, with: "Alex"
    fill_in :street, with: "123 Dutch"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: "80226"
    fill_in :reason, with: "Because animals are great"
    expect(page).to have_button("Save")
    click_button "Save"

    expect(current_path).to eq("/pet_applications/#{pet_application.id}")
    expect(page).to have_content("#{pet_application.name}'s application")
  end
end
