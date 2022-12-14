require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @app1 = Application.create(name: "Max", street_address: "Made up St", city: "Denver", state: "CO", zip_code: "80000", description: "Love mix breeds. Lots of energy to play with a dog", status: "In Progress")
    @app2 = Application.create(name: "Alastair", street_address: "Fictional St", city: "Golden", state: "CO", zip_code: "80001", description: "Love big dogs. Great mountain walks on doorstep", status: "Accepted")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet1 = @app1.pets.create(name: 'Noodle', age: 2, breed: 'Border Collie', adoptable: true, shelter_id: @shelter.id)
    @pet2 = @app1.pets.create(name: 'Hercules', age: 2, breed: 'American Akita', adoptable: true, shelter_id: @shelter.id)
  end

  it 'has a form to create a new application' do
    visit "/applications/new"

    fill_in 'Name', with: "Max"
    fill_in 'Street address', with: "Made up St"
    fill_in 'City', with: "Denver"
    fill_in 'State', with: "CO"
    fill_in 'Zip code', with: "80000"
    click_button "Submit"

    expect(current_path).to eq("/applications/#{(Application.last.id)}")
    expect(page).to have_content("Max")
    expect(page).to have_content("Made up St")
    expect(page).to have_content("In Progress")
  end

  it 'will not submit the form without all proper information' do
    visit "/applications/new"

    fill_in 'street_address', with: 'Made up St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: "CO"
    click_button "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not created. Please complete all fields.")
  end
end