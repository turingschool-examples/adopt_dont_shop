require 'rails_helper'

RSpec.describe 'The admin applications show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: 'Fake', city: 'Denver, CO', foster_program: true, rank: 15)

    @app_1 = Application.create(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
    @app_2 = Application.create(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
    @app_3 = Application.create(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'pending', description: 'safe')
    @app_4 = Application.create(name: 'No pets', street: '20 Gath st', city: 'Marco', state: 'Florida', zip_code: 34145, application_status: 'in progress', description: 'safe')

    @pet_1 = @app_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = @app_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = @app_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_2.id)
    @pet_4 = @app_3.pets.create(name: 'Toby', breed: 'golden', age: 1, adoptable: true, shelter_id: @shelter_3.id)

    visit "/admin/applications/#{@shelter_1.id}"
  end
  it 'displays a button for each pet that the application is for' do
    expect(page).to have_button("Adopt #{@pet_1}")
    expect(page).to have_button("Adopt #{@pet_2}")
  end

  it 'that button succesfully approves the pet adoption'
end
