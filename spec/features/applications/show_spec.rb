require 'rails_helper'

RSpec.describe 'application show page' do
  let!(:application_1) { Application.create!(name: 'Bob', street_address: '1234 Southeast St',
                                            city: 'San Francisco', state: 'CA', zip_code: 12345,
                                            description: 'Wants a dog', name_of_pet: 'Lobster', application_status: "In Progress") }

  let!(:application_2) { Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
                                            city: 'San Francisco', state: 'CA', zip_code: 54321,
                                            description: 'Would like a siamese cat', name_of_pet: 'Lucille Bald', application_status: "In Progress") }

  let!(:application_3) { Application.create!(name: 'Fred', street_address: '376 Monroe St',
                                            city: 'Los Angeles', state: 'CA', zip_code: 67890,
                                            description: 'Interested in sibling pets', name_of_pet: 'Beethoven', application_status: "In Progress") }
  
  let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }

  let!(:pet_1) { Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: shelter_1) }
  let!(:pet_2) { Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter: shelter_2) }
  let!(:pet_3) { Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter: shelter_3) }

  before do
    PetsApplication.create!(application: application_1, pet: pet_2)
    PetsApplication.create!(application: application_2, pet: pet_1)
    PetsApplication.create!(application: application_3, pet: pet_3)
  end

  it 'displays application information' do
    visit "/applications/#{application_1.id}"
    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.application_status)
  end

  it 'has a link to each pets show page' do
    visit "/applications/#{application_1.id}"

    click_link("#{pet_2.name}")
        
    expect(current_path).to eq("/pets/#{pet_2.id}")
  end

  it 'lists partial matches as search results' do
    visit "/applications/#{application_1.id}"

    fill_in(:search_pet, with: 'Lobster')
    click_button('Search Pet')

    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_3.name)
    expect(current_path).to eq("/applications/#{application_1.id}")
  end
    
  it 'can add a pet to an application' do
    visit "/applications/#{application_1.id}"
    
    fill_in(:search_pet, with: 'Lobster')
    click_button('Search Pet')

    expect(page).to have_content(pet_2.name)
    expect(current_path).to eq("/applications/#{application_1.id}")
    
    click_button('Adopt This Pet')
    
    expect(page).to have_content(pet_2.name)
    expect(current_path).to eq("/applications/#{application_1.id}")
  end

  it 'can enter a description on why applicant would make a good owner and submit application' do
    visit "/applications/#{application_1.id}"

    fill_in(:description, with: 'Description:')
    click_button('Submit Your Application')

    expect(page).to have_content("Pending")
    expect(current_path).to eq("/applications/#{application_1.id}")
  end

  it 'cannot submit application if no pets are added to application' do
    visit "/applications/#{application_1.id}"

    # if pets_application

    expect(page).to_not have_button("Submit Your Application")
  end
end