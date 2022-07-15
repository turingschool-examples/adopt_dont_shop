require 'rails_helper'

RSpec.describe 'application creation' do 
   it "creates a new application" do 
      visit '/applications/new'

      fill_in 'Name', with: 'Shirley DeCesari'
      fill_in 'street_address', with: '2482 Magic Flower Ave.'
      fill_in 'city', with: 'Reno'
      fill_in 'state', with: 'Nevada'
      fill_in 'zip_code', with: '89231'

      click_button 'Submit'

      epxect(current_path).to eq('/applications/new')
      expect(page).to have_content('Shirley Decesari')
      expect(page).to have_button('Submit')
   end
end