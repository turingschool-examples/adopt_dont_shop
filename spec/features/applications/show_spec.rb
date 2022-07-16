require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'lists applications attributes' do
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 0)
    app2 = Application.create!(name: 'Calliope Carson', street_address: '124 Central Avenue', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I really love animals!', status: 1)

    visit "/applications/#{app.id}"

    expect(page).to have_content('Brigitte Bardot')
    expect(page).to have_content('123 Main Street, Denver, CO 80111')
    expect(page).to have_content('I love animals!')
    expect(page).to have_content('In Progress')
    expect(page).to_not have_content('Calliope Carson')
    expect(page).to_not have_content('124 Central Avenue, Denver, CO, 80111')
    expect(page).to_not have_content('Pending')
  end

  it 'lists the names of all pets that this application is for as links to their show pages' do
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 0)
    app2 = Application.create!(name: 'Calliope Carson', street_address: '124 Central Avenue', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I really love animals!', status: 1)

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pirate = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    clawdia = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    lucy = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    ApplicationPet.create!(application: app, pet: pirate)
    ApplicationPet.create!(application: app, pet: lucy)

    visit "/applications/#{app.id}"

    expect(page).to have_link('Mr. Pirate')
    expect(page).to have_link('Lucille Bald')
    click_link 'Lucille Bald'
    expect(current_path).to eq("/pets/#{lucy.id}")
  end

  it 'has a section to search for pets by name' do
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 0)
    app2 = Application.create!(name: 'Calliope Carson', street_address: '124 Central Avenue', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I really love animals!', status: 1)

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pirate = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    clawdia = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    lucy = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    ApplicationPet.create!(application: app, pet: pirate)
    ApplicationPet.create!(application: app, pet: lucy)

    visit "/applications/#{app.id}"

    expect(page).to_not have_content('Clawdia')

    fill_in 'Search', with: 'Clawdia'
    click_button 'Submit'
    save_and_open_page

    expect(current_path).to eq "/applications/#{app.id}"
    expect(page).to have_content('Clawdia')
  end
end
