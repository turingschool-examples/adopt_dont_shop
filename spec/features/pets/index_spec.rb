require 'rails_helper'

RSpec.describe 'the pets index' do
  it 'lists all the pets with their attributes' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it 'only lists adoptable pets' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to_not have_content(pet_3.name)
  end

  it 'displays a link to edit each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit '/pets'
    expect(page).to have_button('Search')
  end

  it 'lists partial matches as search results' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit '/pets'

    fill_in 'Search', with: 'Ba'
    click_on('Search')

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  it 'displays a link to start an application' do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    ap1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)

    visit '/pets'

    click_link('Start an Application')

    expect(current_path).to eq('/applications/new')

    fill_in('Name', with: 'Sylvester Tommy')

    # fill_in('Street Address', with: '1827 Vincent Ave')

    fill_in('City', with: 'Denver')

    fill_in('State', with: 'Colorado')

    # fill_in('Zipcode', with: '38271')

    fill_in('Description', with: 'I LOVE pets')

    click_button('Submit')

    expect(current_path).to eq("applications/#{application.last.id}")

    expect(page).to have_content('Sylvester Tommy')

    expect(page).to have_content('1827 Vincent Ave')

    expect(page).to have_content('Denver')

    expect(page).to have_content('Colorado')

    expect(page).to have_content('38271')

    expect(page).to have_content('I LOVE pets')

    expect(page).to have_content('In Progress')
  end
end
