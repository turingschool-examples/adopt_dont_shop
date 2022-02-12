require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @shelter = Shelter.create(name: 'Maxfund', city: 'Denver CO', foster_program: false, rank: 9)
    @application_1 = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "New York", state: "NY", zipcode: "12345", description: "I wouldn't be a good pet owner", status: "Pending")
    @pet_1 = Pet.create(adoptable: true, age: 2, breed: 'domestic short hair', name: 'Mundungous', shelter_id: "#{@shelter.id}")
    @pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Captain Pants', shelter_id: "#{@shelter.id}")

    @pet_app = PetApplication.create!(pet_id: pet_1.id, application_id: @application_1.id)
    @pet_app = PetApplication.create!(pet_id: pet_2.id, application_id: @application_1.id)
  end

  it "shows the application and all it's attributes" do
    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zipcode)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(application_1.status)
  end

  it 'includes a link to each pet page' do
    visit "/applications/#{application.id}"

    click_on("#{pet_1.name}")

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
