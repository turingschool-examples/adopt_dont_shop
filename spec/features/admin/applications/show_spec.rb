require 'rails_helper'

RSpec.describe 'the admin shelter show page ' do
  it 'shows all the pets on the applicatrion' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    spot = application.pets.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    bognart = application.pets.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Bognart', shelter_id: shelter[:id])
    poopy = application.pets.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Poopy', shelter_id: shelter[:id])
    # app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    visit "/admin/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content(spot.name)
    expect(page).to have_content(bognart.name)
    expect(page).to have_content(poopy.name)
  end

end
