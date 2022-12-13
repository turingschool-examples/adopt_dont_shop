require 'rails_helper'

RSpec.describe 'the veterinarian update' do
  it 'shows the veterinarian edit form' do
    shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
    pet = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter.id)

    visit "/pets/#{pet.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Breed')
    expect(find('form')).to have_content('Adoptable')
    expect(find('form')).to have_content('Age')
  end

  context 'given valid data' do
    it 'submits the edit form and updates the veterinarian' do
      shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
      pet = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)

      visit "/pets/#{pet.id}/edit"

      fill_in 'Name', with: 'Itchy'
      uncheck 'Adoptable'
      fill_in 'Age', with: 1
      click_button 'Save'

      expect(page).to have_current_path("/pets/#{pet.id}")
      expect(page).to have_content('Itchy')
      expect(page).to_not have_content('Charlie')
    end
  end

  context 'given invalid data' do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)
      pet = Pet.create(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: shelter.id)

      visit "/pets/#{pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{pet.id}/edit")
    end
  end
end
