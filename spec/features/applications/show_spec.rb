require 'rails_helper'

RSpec.describe "Application Show Page" do
  it "should show applicant information" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dragon', name: 'Blake C', shelter_id: @shelter_1.id)
    application = Application.create!(name: "Chaz Carmichael",
      street_address: "10 lane",
      city: "Sandy Springs",
      state: "CO",
      zipcode: 12345,
      description: "I like pets",
      status: "In Progress")
    pet_application = PetApplication.create!(pet_id: pet_1.id, application_id: application.id)
    pet_application2 = PetApplication.create!(pet_id: pet_2.id, application_id: application.id)
    visit "/application/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    click_on('Lucille Bald')
    expect(current_path).to eq("/application/pets/#{pet_1.id}")
    visit "/application/#{application.id}"
    click_on('Blake C')
    expect(current_path).to eq("/application/pets/#{pet_2.id}")
  end
end
