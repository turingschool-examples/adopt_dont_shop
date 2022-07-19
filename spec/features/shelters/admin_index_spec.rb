require 'rails_helper'

RSpec.describe 'Shelter Admin Index' do
  describe 'As a visitor' do
    it 'will show me all the Shelters in the system lised in reverse alphabetical order by name' do
      islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hospital", city: "Denver", rank: 8)
      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
      banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9)

      visit '/admin/shelters'
      
      within '#shelter-0' do
        expect(page).to have_content("North Shore Animal Hospital")
      end
      within '#shelter-1' do
        expect(page).to have_content("Island Lake Animal Hospital")
      end
      within '#shelter-2' do
        expect(page).to have_content("Banfield Animal Hospital")
      end
    end
  end
end