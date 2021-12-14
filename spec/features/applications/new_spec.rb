require 'rails_helper'

RSpec.describe 'The new application page' do
  before(:each) do
    @application_1 = Application.create!(name: "Robin Dittrich", address: "111 Get Stoked Ave", city: "Bellingham", state: "WA", zip:"98225", description:"Mid sized home with two other dogs that need another friend", status: "pending")
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_application_1 = @application_1.pet_applications.create!(pet_id: @pet_1.id)
    @pet_application_1 = @application_1.pet_applications.create!(pet_id: @pet_2.id)
  end

  it 'includes a form to fill with name, address, city, state, zip' do
    visit 'applications/new'

    fill_in("Name", with: "Harry Potter")
    fill_in("Address", with: "121 Magic Lane")
    fill_in("City", with: "Hogwarts")
    fill_in("State", with: "Washington")
    fill_in("Zip", with: "99999")
    fill_in("Description", with: "Looking for a Dragon")
    fill_in("Status", with: "In Progress")

    click_button('Submit')

    new_application_id = Application.last.id
    expect(current_path).to eq("/applications/#{new_application_id}")
    expect(page).to have_content("Harry Potter")
    expect(page).to have_content("Looking for a Dragon")
    expect(page).to have_content("In Progress")
  end
end
