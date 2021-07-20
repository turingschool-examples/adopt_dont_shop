require 'rails_helper'

RSpec.describe 'the application show page' do
  it "shows the application and all it's fields" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    app = Application.create(name: 'Big Bird', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'in progress', description: 'kind')

    visit "/applications/#{app.id}"

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.street)
    expect(page).to have_content(app.zip_code)
    expect(page).to have_content(app.application_status)
    expect(page).to have_button('Search')
  end

  it "searches for pets to be able to submit" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    app = Application.create(name: 'Big Bird', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'in progress', description: 'kind')

    visit "/applications/#{app.id}"
    expect(page).to have_content('Error')
    fill_in :search, with: 'Scooby'
    click_on 'Search'

    expect(page).to have_content("#{pet.name}")
    expect(page).to have_content("#{pet.name}")
    expect(page).to have_content("#{pet.breed}")
  end

  it "fills in and actually submits the application" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    app = Application.create(name: 'Big Bird', street: '2534 Tan Blvd', city: 'Boulder', state: 'Colorado', zip_code: 80204, application_status: 'in progress', description: 'kind')

    visit "/applications/#{app.id}"
    fill_in "Add a Pet to this Application", with: 'Scooby'

    click_button('Search')
    click_button "Adopt: #{pet.name}"
    click_on 'Submit'

    expect(page).to have_content('Pending')
  end
