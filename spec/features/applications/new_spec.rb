require 'rails_helper'

RSpec.describe 'New Application' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

    @application = Application.create!({
                                         name: 'Jeff',
                                         street_address: '123 Main Street',
                                         city: 'Denver',
                                         state: 'CO',
                                         zip_code: 22_314,
                                         reason: 'Nice person'
                                       })

    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
  end

  it 'has a form to create a new application' do
    visit '/applications/new'

    fill_in 'Name', with: 'Sam'
    fill_in 'street_address', with: '123 Elm Street'
    fill_in 'City', with: 'Denver'
    select('Colorado', from: 'state')
    fill_in 'zip_code', with: 80_210

    click_button 'Submit'

    expect(current_path).to eq("/applications/#{Application.last.id}")

    expect(page).to have_content('Sam')
    expect(page).to have_content('123 Elm Street, Denver CO, 80210')
    expect(page).to have_content('In Progress')
  end

  it 'will not submit the form without all proper information' do
    visit '/applications/new'

    fill_in 'street_address', with: '123 Elm Street'
    fill_in 'City', with: 'Denver'
    select('Colorado', from: 'state')

    click_button 'Submit'

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Zip code can't be blank")
  end
end
