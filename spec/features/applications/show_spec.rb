require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content('Pet(s) applying for: Spot')
  end

  it "searches for pets and adds them to an application" do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    chungus = Pet.create!(adoptable: true, age: 15, breed: 'Chihuahua', name: 'Chungus', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")

    fill_in 'Search', with: 'Spot'
    click_button 'Submit'

    expect(current_path).to eq("/applications/#{application.id}/")

    expect(page).to have_content("Spot")
    expect(page).to_not have_content("Chungus")
  end


end
