require 'rails_helper'

RSpec.describe 'The admin applications show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)

    @app_1 = Application.create(name: 'Beetlejuice', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
    @app_2 = Application.create(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')

    @pet_1 = @app_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = @app_1.pets.create(name: 'Franklin', breed: 'turtle', age: 3, adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = @app_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_2.id)
    @pet_4 = @app_2.pets.create(name: 'Toby', breed: 'golden', age: 1, adoptable: true, shelter_id: @shelter_2.id)

    visit "/admin/applications/#{@app_1.id}"
  end
  it 'displays a button for each pet that the application is for' do
    expect(page).to have_link("Approve #{@app_1.name} to adopt #{@pet_1.name}")
    expect(page).to have_link("Approve #{@app_1.name} to adopt #{@pet_2.name}")
  end

  it 'that button succesfully approves the pet adoption'
end
