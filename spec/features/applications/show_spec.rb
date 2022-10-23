require 'rails_helper'

RSpec.describe 'Application Show' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Frog', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end

  it 'lists the select application with its attributes' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.first)
    expect(page).to have_content(@app_1.last)
    expect(page).to have_content(@app_1.street)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end

  it 'has a section to add an additional pet to the application' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Add a pet to this Application")
  end

  it 'has a section to search for a pet to add' do
    visit "/applications/#{@app_1.id}"
    fill_in :search, with: "#{@pet_3.name}"
    click_on "Submit"

    expect(page).to have_content(@pet_3.name)
  end
end