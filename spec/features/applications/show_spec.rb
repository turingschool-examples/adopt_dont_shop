require 'rails_helper'

RSpec.describe 'applications show page' do

  it "displays applicant attributes" do
    application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Pending')
    shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)
    PetApplication.create(pet: pet_1, application: application_1)

    visit "/applications/#{application_1.id}"
    # save_and_open_page

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zipcode)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.status)
  end

  it 'can display Adopt This Pet button next to each pets name' do
    application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'In Progress')
    shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)

    visit "/applications/#{application_1.id}"
    expect(page).to_not have_content('Queso')

    fill_in(:search, with: 'Queso')
    click_button("Search")

    click_link("Adopt this Pet")

    expect(current_path).to eq("/applications/#{application_1.id}")

    expect(page).to have_content("Queso")
  end

  it 'after pets added to app - description prompt & submit button appears' do
    application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'In Progress')
    shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)

    visit "/applications/#{application_1.id}"
    expect(page).to_not have_content('Queso')

    fill_in(:search, with: 'Queso')
    click_button("Search")

    click_link("Adopt this Pet")
    # save_and_open_page
    fill_in(:description, with: 'Really REALLY good guy')
    # save_and_open_page
    click_button("submit")

    expect(current_path).to eq("/applications/#{application_1.id}")


    expect(page).to_not have_content("In Progress")
    # expect(page).to_not have_content('div.pet_search')
    expect(page).to have_content("Pending")
  end

  it "doesn't show submit if you haven't added pets" do
    application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'In Progress')
    shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)

    visit "/applications/#{application_1.id}"
    expect(page).to_not have_content("submit")
  end

  it "can display both partial search and case insensitive matches" do
    application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'In Progress')
    shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
    pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)

    visit "/applications/#{application_1.id}"

    fill_in :search, with: "que"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
  end
end
