require 'rails_helper'

RSpec.describe 'show page' do

  it "shows the application and pet attributes/links" do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content("Name: #{application.name}")
    expect(page).to have_content("Address: #{application.address}")
    expect(page).to have_content("City: #{application.city}")
    expect(page).to have_content("State: #{application.state}")
    expect(page).to have_content("Zipcode: #{application.zip_code}")
    expect(page).to have_content("Description: #{application.description}")


    expect(page).to have_content("Application Status: #{application.status}")

    fill_in 'Search', with: "luc"
    click_on('Submit')

    click_on "#{pet_1.name}"

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it "can search for a pet" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'LUCCY', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'lucccccc', shelter_id: shelter.id)
    pet_4 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)


    visit "/applications/#{application.id}"


    fill_in 'Search', with: "luc"
    click_on('Submit')

    expect(current_path).to eq("/applications/#{application.id}")

    within "#pet-#{pet_1.id}" do
      expect(page).to have_link("Pet Name: #{pet_1.name}")
      expect(page).to have_content(pet_1.name)
    end
    within "#pet-#{pet_2.id}" do
      expect(page).to have_link("Pet Name: #{pet_2.name}")
      expect(page).to have_content(pet_2.name)
    end
    within "#pet-#{pet_3.id}" do
      expect(page).to have_link("Pet Name: #{pet_3.name}")
      expect(page).to have_content(pet_3.name)
    end

    expect(page).to have_content("Add a pet to this Application")

    expect(page).not_to have_content(pet_4.name)
  end

  it "can add a pet to an application" do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in 'Search', with: "luc"
    click_on('Submit')

    within("#pet-#{pet_1.id}") do
      click_on("Adopt this Pet")
    end

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(pet_1.name)
    application_pet = ApplicationPet.last

    expect(application_pet.application_id).to eq(application.id)
    expect(application_pet.pet_id).to eq(pet_1.id)
  end

  it "user can submit an application after adding pets" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    within("#app-submission") do
      expect(page).not_to have_button('Submit this Application')
    end

    fill_in 'Search', with: "luc"
    click_on('Submit')

    within("#pet-#{pet_1.id}") do
      click_on("Adopt this Pet")
    end

    within("#app-submission") do
      expect(page).to have_button('Submit this Application')

      fill_in 'Description', with: 'I love pets'

      click_on('Submit this Application')
    end
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content('Pending')

    updated_app = Application.find(application.id)

    expect(updated_app.status).to eq('Pending')
    expect(updated_app.description).to eq('I love pets')

    expect(page).not_to have_content('Add a pet to this Application')
    expect(page).to have_content(pet_1.name)
    expect(page).not_to have_content(pet_2.name)
  end
end
