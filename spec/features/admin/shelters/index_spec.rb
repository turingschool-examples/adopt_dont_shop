require 'rails_helper'

RSpec.describe 'Admin/shelters#index' do
  describe 'when I visit the admin shelters index page' do

    it 'shows me that I am on the admin shelters index page' do
      visit '/admin/shelters'
      expect(page).to have_content('All Shelters-Admin View')
    end

    it 'I see all shelters ordered by reverse alphabetical order' do
      dog_homes = Shelter.create!(name: "Dog Home", city: "Denver", rank: 1, foster_program: true)
      paw_place = Shelter.create!(name: "Paw Place", city: "Boulder", rank: 2, foster_program: true)
      furry_friends = Shelter.create!(name: "Furry Friends", city: "Aurora", rank: 3, foster_program: false)
      
      visit '/admin/shelters'

      within("#pet_shelters_admin") do
        expect("Paw Place").to appear_before("Furry Friends")
        expect("Furry Friends").to appear_before("Dog Home")
      end
    end
  end
end