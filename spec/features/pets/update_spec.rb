require 'rails_helper'

RSpec.describe 'the veterinarian update' do
  
  before(:each) do
    @shelter = create(:shelter)
    @pet = create(:pet, shelter_id: @shelter.id)
  end

  it 'shows the veterinarian edit form' do
    visit "/pets/#{@pet.id}/edit"
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Breed')
    expect(find('form')).to have_content('Adoptable')
    expect(find('form')).to have_content('Age')
  end

  context 'given valid data' do
    it 'submits the edit form and updates the veterinarian' do
      visit "/pets/#{@pet.id}/edit"

      fill_in 'Name', with: 'Itchy'
      uncheck 'Adoptable'
      fill_in 'Age', with: 1
      click_button 'Save'

      expect(page).to have_current_path("/pets/#{@pet.id}")
      expect(page).to have_content('Itchy')
      expect(page).to_not have_content('Charlie')
    end
  end

  context 'given invalid data' do
    it 're-renders the edit form' do
      visit "/pets/#{@pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{@pet.id}/edit")
    end
  end
end
