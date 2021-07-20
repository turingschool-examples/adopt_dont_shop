require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @app_1 = Application.create!(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
    @app_2 = Application.create!(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
    @app_3 = Application.create!(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'approved', description: 'safe')
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
  end

  it 'renders the new form' do
    visit "/applications/new"

    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip Code')
    expect(find('form')).to have_button('Create Application')
  end

  it 'submits the new form' do
    visit "/applications/new"

    fill_in :name, with: "Brian F"
    fill_in :street, with: "123 Main St."
    fill_in :city, with: "Marco Island"
    fill_in :state, with: "FL"
    fill_in :zip_code, with: "34145"
    click_button('Create Application')

    expect(page).to have_content("Brian F")
    expect(page).to have_content("123 Main St.")

  end
end
