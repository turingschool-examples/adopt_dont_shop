require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    app_pet = ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
  end

  it 'checks the new application link' do
    visit "/pets"

    click_link 'Start Application'

    expect(page).to have_current_path('/applications/new')
  end

  it 'gets data from the user and creates a new form' do
    visit "/applications/new"

    fill_in 'Name', with: 'Spot'
    fill_in 'Street address', with: '100 Westland'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip code', with: '87654'
    click_button 'Create'
    application = Application.last

    expect(page).to have_content('Spot')
    expect(page).to have_content('Denver')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('In Progress')
    expect(current_path).to eq("/applications/#{application.id}")
  end

  it "factors for blank fields of the form" do
    visit "/applications/new"

    click_button 'Create'

    expect(page).to have_content('You can not leave any of the fields blank.')
    expect(current_path).to eq("/applications/new")
  end

end
