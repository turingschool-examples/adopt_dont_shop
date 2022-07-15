require 'rails_helper'

RSpec.describe 'Show application', type: :feature do
  it 'shows the application' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs", status: "pending")
    application_2 = Application.create!(id: 2, name: 'Jane Doe', street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 10002, description: "I love cats", status: "pending")
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
    expect(page).to have_content("pending")


    expect(page).to have_no_content("Jane Doe")
    expect(page).to have_no_content("456 Main St")
    expect(page).to have_no_content("Boston")
    expect(page).to have_no_content("MA")
    expect(page).to have_no_content(10002)
    expect(page).to have_no_content("I love cats")
  end
end

end