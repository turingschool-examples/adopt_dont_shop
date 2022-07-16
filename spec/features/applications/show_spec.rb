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
    # save_and_open_page

    expect(current_path).to eq "/applications/#{app.id}"
    expect(page).to have_content('Clawdia')
  end

  it 'it has a button to add the pet after searching for it' do
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 0)

    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pirate = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    clawdia = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    lucy = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    ApplicationPet.create!(application: app, pet: pirate)
    ApplicationPet.create!(application: app, pet: lucy)

    visit "/applications/#{app.id}"
    # save_and_open_page

    expect(page).to_not have_content('Clawdia')

    fill_in 'Search', with: 'Clawdia'
    click_button 'Submit'

    expect(current_path).to eq "/applications/#{app.id}"
    expect(page).to have_content('Clawdia')
    expect(page).to have_button('Adopt this Pet')

    click_button('Adopt this Pet')
    # save_and_open_page

    expect(current_path).to eq "/applications/#{app.id}"

    within("#pets") do 
      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Mr. Pirate')
      expect(page).to have_content('Clawdia')
    end
  end

  it 'allows submission of the application if it has one or more pets' do 
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', status: 0)

    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pirate = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    clawdia = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    lucy = shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    ApplicationPet.create!(application: app, pet: pirate)
    ApplicationPet.create!(application: app, pet: lucy)

    visit "/applications/#{app.id}"
    # save_and_open_page

    expect(page).to have_content 'Finalize and Submit Your Application'
    expect(page).to have_content 'Please tell us why you would make a good owner for the pets.'
    expect(page).to have_button 'Submit Application' 

    fill_in :description, with: 'I love animals!' 
    click_button 'Submit Application' 
    # save_and_open_page

    expect(current_path).to eq("/applications/#{app.id}")
    expect(page).to have_content 'Pending' 
    expect(page).to have_content 'Mr. Pirate' 
    expect(page).to have_content 'Lucille Bald' 
    expect(page).to_not have_content 'Add a Pet to this Application' 
  end

  it 'does not show section to submit application if there are no pets on the app' do 
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', status: 0)

    visit "/applications/#{app.id}"
    # save_and_open_page

    expect(page).to_not have_content 'Finalize and Submit Your Application'
    expect(page).to_not have_content 'Please tell us why you would make a good owner for the pets.'
    expect(page).to_not have_button 'Submit Application'
  end

  it 'shows partial matches for the pet search' do 
    app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', description: 'I love animals!', status: 0)

    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    fluff1 = shelter_1.pets.create!(name: 'Fluffy', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    fluff2 = shelter_1.pets.create!(name: 'Fluff', breed: 'shorthair', age: 3, adoptable: true)
    fluff3 = shelter_3.pets.create!(name: 'Mr. Fluff', breed: 'sphynx', age: 8, adoptable: true)

    visit "/applications/#{app.id}"
    # save_and_open_page

    fill_in 'Search', with: 'fluff'
    click_button 'Submit'

    expect(page).to have_content('Fluffy')
    expect(page).to have_content('Fluff')
    expect(page).to have_content('Mr. Fluff')
  end
end
