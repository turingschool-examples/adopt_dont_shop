require 'rails_helper'
# As a visitor
# When I visit an admin shelter show page
# Then I see that shelter's name and full address
RSpec.describe 'admin shelter show page' do 
   it "displays the shelter's name and full address" do 
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Aurora shelter")
      expect(page).to have_content(@shelter_1.city)
      expect(page).to_not have_content("Fancy pets of Colorado")
   end
end