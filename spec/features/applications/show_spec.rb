require 'rails_helper'

RSpec.describe 'show page' do

  it "shows the application and pet attributes/links" do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: 'Ted', address: '11 revere dr.', city: 'salt lake', state: 'Colorado', zip_code: '60010', description: 'I love pets', status: 'In Progress')
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    ApplicationPet.create!(application_id: application.id, pet_id: pet_1.id, )
    ApplicationPet.create!(application_id: application.id, pet_id: pet_2.id, )

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
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)


    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a pet to this Application")

    fill_in 'Search', with: "luc"
    click_on('Submit')

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_link("Pet Name: #{pet_1.name}")
    expect(page).to have_content(pet_1.name)
    expect(page).not_to have_content(pet_2.name)
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
  end
# "  [ ] done
#
# Submit an Application
#
# As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application"
end
