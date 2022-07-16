require 'rails_helper'

RSpec.describe 'application creation' do
   it "creates a new application" do
      visit '/applications/new'

      fill_in 'name', with: 'Thomas Turner'
      fill_in 'address_street', with: '234 Sands St.'
      fill_in 'address_city', with: 'Chicago'
      fill_in 'address_state', with: 'Illinois'
      fill_in 'address_zip_code', with: '60007'
      fill_in 'description', with:  "I love pets and have lots of space in the back yard"
      click_button 'Submit'

      expect(page).to have_content('Thomas Turner')
   end

   it 'has required fields' do
     visit '/applications/new'

     click_button 'Submit'

     expect(current_path).to eq('/applications/new')
     expect(page).to have_content("Please fill all fields")
   end
end
