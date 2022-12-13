require 'rails_helper'

RSpec.describe 'the shelter update' do
  it 'shows the shelter edit form' do
    shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

    visit "/shelters/#{shelter.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('Rank')
    expect(find('form')).to have_content('Foster program')
  end

  context 'given valid data' do
    it 'submits the edit form and updates the shelter' do
      shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'Name', with: 'Wichita Shelter'
      fill_in 'street_address', with: '1236 2nd St'
      fill_in 'City', with: 'Wichita'
      fill_in 'zip_code', with: 50236
      uncheck 'Foster program'
      fill_in 'Rank', with: 10
      click_button 'Save'

      expect(page).to have_current_path('/shelters')
      expect(page).to have_content('Wichita Shelter')
      expect(page).to_not have_content('Houston Shelter')
    end
  end

  context 'given invalid data' do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

      visit "/shelters/#{shelter.id}/edit"

      fill_in 'Name', with: ''
      fill_in 'City', with: 'Wichita'
      uncheck 'Foster program'
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/shelters/#{shelter.id}/edit")
    end
  end
end
