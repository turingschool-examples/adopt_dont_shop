require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657', description: 'greate person', status: 'pending')
    @pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
  end

  describe 'the index page has a link to go to a new form' do
    it 'renders the new form' do
      visit "/pets"

      expect(page).to have_link("Start an Application")
      click_link("Start an Application")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content('New Application')
      expect(page).to have_content('Name')
      expect(page).to have_content('Street')
      expect(page).to have_content('City')
      expect(page).to have_content('State')
      expect(page).to have_content('Zip')

      fill_in 'Name', with: "Kathy Y"
      fill_in 'Street', with: '434 W. Roscoe'
      fill_in 'City', with: 'Chicago'
      fill_in 'State', with: 'IL'
      fill_in 'Zip', with: '60657'

      click_button 'Save'
      application = Application.find_by(name:'Kathy Y')
      expect(page).to have_current_path("/applications/#{application.id}")

    end
  end
end
