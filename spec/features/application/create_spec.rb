require 'rails_helper'

RSpec.describe 'the application create' do
  it 'can create a new application' do

    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '90210'

    click_button "Submit"
    
    expect(page).to have_content('Jimbo Jones')
    expect(page).to have_content('123 Fake St Denver CO 90210')
    expect(page).to have_content('In Progress')
  end

  it 'returns an error if application is not complete' do
    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'

    click_button "Submit"
    
    expect(page).to have_content("Error: Zip code can't be blank")
  end

  describe 'pet search' do
    it 'can search for a pet' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a pet to this application:")

      fill_in 'pet', with: 'Fluffy'
      click_button 'Submit'

      expect(page).to have_content('Fluffy')
    end
  end
end
