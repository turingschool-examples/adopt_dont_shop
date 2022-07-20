require 'rails_helper'

RSpec.describe 'Admin Shelter Show' do
  describe 'As a visitor' do
    it 'will show the name and full address of the specified Shelter' do
      northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

      visit "/admin/shelters/#{northshore.id}"

      expect(page).to have_content(northshore.name)
      expect(page).to have_content(northshore.city)
      expect(page).to have_content(northshore.street_address)
      expect(page).to have_content(northshore.state)
      expect(page).to have_content(northshore.zip_code)
    end
  end
end