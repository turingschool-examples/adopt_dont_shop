require 'rails_helper'

RSpec.describe 'application show page' do
  it 'shows full address of applicant' do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    ap1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    visit "/applications/#{application.id}"

    expect(page).to have_content('Sylvester Tommy')
    expect(page).to have_content('1827 Vincent Ave')
    expect(page).to have_content('Halifax')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('19274')
    expect(page).to have_content('I LOVE pets')
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Suzan')

    click_link('Suzan')

    expect(current_path).to eq("/pets/#{pet1.id}")
  end

  it 'lets you add a pet to an unsubmitted application' do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 3, breed: 'Poodle', name: 'Spot', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content('In Progress')
    expect(page).to have_content('Add a Pet to this Application')

    fill_in('Search', with: 'Spot')
    click_button('Search')

    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content('Spot')
    expect(page).to_not have_content('Suzan')
  end

  it 'adds a pet to the application' do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 3, breed: 'Poodle', name: 'Spot', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in('Search', with: 'Spot')

    click_button('Search')

    click_button('Adopt this Pet')

    expect(current_path).to eq("/applications/#{application.id}")

    expect('Spot').to appear_before('Status')
  end

  it "allows for the user to submit their application" do
    shelter = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: '', status: 'In Progress')
    pet1 = Pet.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan', shelter_id: shelter.id)
    pet2 = Pet.create!(adoptable: true, age: 3, breed: 'Poodle', name: 'Spot', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in('Search', with: 'Spot')
    click_button('Search')
    click_button('Adopt this Pet')

    expect(page).to have_content('Submit Application')

    fill_in('Why would you make a good owner?', with: 'I love animals.')
    click_button('Submit')

    expect(current_path).to eq("/applications/#{application.id}")

    expect(page).to have_content('Pending')
    expect(page).to_not have_content('Search')
    expect(page).to_not have_content('Submit Application')
  end
end
