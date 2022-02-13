require 'rails_helper'

RSpec.describe 'applications new page' do

  it 'has form for new application' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
    

    visit "/applications/new"
    fill_in('Name', with: "Teddy")
    fill_in('Street', with: "39 goldcup dr")
    fill_in('City', with: "fredericksburg")
    fill_in('State', with: "VA")
    fill_in('Zip', with: "22406")
    click_button('Submit')
    application_1 = Application.find_by(name:'Teddy')
    expect(current_path).to eq("/applications/#{application_1.id}")
    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip)
  end

  it 'gives an error when all fields are not completed' do
    visit "/applications/new"
    click_button('Submit')
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content('Error, all fields must be completed')
  end
end
