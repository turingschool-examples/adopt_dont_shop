require 'rails_helper'

RSpec.describe 'Show application', type: :feature do
  it 'shows the application' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)
    pet_application_2 = PetApplication.create!(id: 2, application_id: 1, pet_id: 2)

    visit "applications/#{application_1.id}"
    
    within "#app_information" do
    expect(page).to have_content("John Doe")
    expect(page).to have_content("123 Main St")
    expect(page).to have_content("New York")
    expect(page).to have_content("NY")
    expect(page).to have_content(10001)
    expect(page).to have_content("I love dogs")
    expect(page).to have_content("Roofus")
    expect(page).to have_content("Bowow")


    expect(page).to have_no_content("Jane Doe")
    expect(page).to have_no_content("456 Main St")
    expect(page).to have_no_content("Boston")
    expect(page).to have_no_content("MA")
    expect(page).to have_no_content(10002)
    expect(page).to have_no_content("I love cats")
    end
  end

  it 'clicks an application pets and it opens that pets show page' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)
    pet_application_2 = PetApplication.create!(id: 2, application_id: 1, pet_id: 2)

    visit "applications/#{application_1.id}"

    click_link "Roofus"

    expect(current_path).to eq("/pets/1")
  end

  it 'searches for a pet and adds that pet to the application' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)

    visit "applications/#{application_1.id}"

    within("#pet_search") do
      fill_in "search_name", with: "Bowow"
      click_on("Search")
    end

    expect(current_path).to eq("/applications/1")

    within("#pet_found") do
      expect(page).to have_content("Bowow")
      expect(page).to have_button('Add to Application')
    end
  end

  it 'finds a pet by searching for' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)

    visit "applications/#{application_1.id}"

    within "#app_information" do
      expect(page).to have_content("John Doe")
      expect(page).to have_content("123 Main St")
      expect(page).to have_content("New York")
      expect(page).to have_content("NY")
      expect(page).to have_content(10001)
      expect(page).to have_content("I love dogs")
      expect(page).to have_content("Roofus")
      
      expect(page).to have_no_content("Bowow")
    end

    within("#pet_search") do
      fill_in "search_name", with: "Bowow"
      click_on("Search")
    end

    within("#pet_found") do
      click_on("Add to Application")
    end

    within "#app_information" do
      expect(page).to have_content("John Doe")
      expect(page).to have_content("123 Main St")
      expect(page).to have_content("New York")
      expect(page).to have_content("NY")
      expect(page).to have_content(10001)
      expect(page).to have_content("I love dogs")
      expect(page).to have_content("Roofus")
      expect(page).to have_content("Bowow")
    end
  end

  it 'searches and finds a pet using only part of the name and locates that pet' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs", status: "pending")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats", status: "pending")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)

    visit "applications/#{application_1.id}"

    within("#pet_search") do
      fill_in "search_name", with: "Bo"
      click_on("Search")
    end

    expect(current_path).to eq("/applications/1")

    within("#pet_found") do
      expect(page).to have_content("Bowow")
      expect(page).to have_button('Add to Application')
    end
  end

  it 'searches for and finds a pet with a partial match' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs", status: "pending")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats", status: "pending")
    roofus = Pet.create!(id: 1, name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    bowow = Pet.create!(id: 2, name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)

    visit "applications/#{application_1.id}"

    within("#pet_search") do
      fill_in "search_name", with: "wo"
      click_on("Search")
    end

    expect(current_path).to eq("/applications/1")

    within("#pet_found") do
      expect(page).to have_content("Bowow")
      expect(page).to have_button('Add to Application')
    end
  end
end