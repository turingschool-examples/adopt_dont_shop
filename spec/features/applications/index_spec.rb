require 'rails_helper'

RSpec.describe 'the application index page' do
  before(:each) do
    @app_1 = Application.create!(name: 'Caroline Tan', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'pending', description: 'kind')
    @app_2 = Application.create!(name: 'Ezze Alwfai', street: '1234 fake st', city: 'Lafayette', state: 'Colorado', zip_code: 80328, application_status: 'pending', description: 'rich')
    @app_3 = Application.create!(name: 'Marla Shulz', street: '2020 Corona st', city: 'Denver', state: 'Colorado', zip_code: 80218, application_status: 'approved', description: 'safe')
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    visit "/applications"
  end

  it 'lists all applications by name' do
    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_2.name)
    expect(page).to have_content(@app_3.name)
  end

  it 'displays a link to edit each pet' do
    expect(page).to have_link("Edit #{@app_1.name}")
    expect(page).to have_link("Edit #{@app_2.name}")

    click_link("Edit #{@app_1.name}")

    expect(current_path).to eq("/applications/#{@app_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    expect(page).to have_button("Delete #{@app_1.name}")
    expect(page).to have_button("Delete #{@app_2.name}")

    click_button("Delete #{@app_1.name}")

    expect(page).to have_current_path("/applications")
    expect(page).to_not have_content(@app_1.name)
    expect(page).to have_content(@app_2.name)
  end
end

  # it 'only lists adoptable pets' do
  #   shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  #   pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
  #
  #   visit "/pets"
  #
  #   expect(page).to_not have_content(pet_3.name)
  # end
  #
  # it 'displays a link to edit each pet' do
  #   shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  #
  #   visit '/pets'
  #
  #   expect(page).to have_content("Edit #{pet_1.name}")
  #   expect(page).to have_content("Edit #{pet_2.name}")
  #
  #   click_link("Edit #{pet_1.name}")
  #
  #   expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  # end
  #
  # it 'displays a link to delete each pet' do
  #   shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  #
  #   visit '/pets'
  #
  #   expect(page).to have_content("Delete #{pet_1.name}")
  #   expect(page).to have_content("Delete #{pet_2.name}")
  #
  #   click_link("Delete #{pet_1.name}")
  #
  #   expect(page).to have_current_path("/pets")
  #   expect(page).to_not have_content(pet_1.name)
  # end
  #
  # it 'has a text box to filter results by keyword' do
  #   visit "/pets"
  #   expect(page).to have_button("Search")
  # end
  #
  # it 'lists partial matches as search results' do
  #   shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
  #   pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
  #   pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
  #
  #   visit "/pets"
  #
  #   fill_in 'Search', with: "Ba"
  #   click_on("Search")
  #
  #   expect(page).to have_content(pet_1.name)
  #   expect(page).to have_content(pet_2.name)
  #   expect(page).to_not have_content(pet_3.name)
  # end
  #
  # it 'has a link to start a new application' do
  #   visit "/pets"
  #   expect(page).to have_link("Start an Application")
  #   click_link("Start an Application")
  #
  #   expect(current_path).to eq("/applications/new")
  # end
