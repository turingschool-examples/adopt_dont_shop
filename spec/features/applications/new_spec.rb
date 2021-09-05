require 'rails_helper'

# # When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

RSpec.describe 'New Application' do
  describe 'As a visitor' do
    describe 'When I visit the new application form by clicking a link on the pet index' do
      it "I can create a new application" do
        visit '/applications/new'

        fill_in 'Name', with: 'Ted'
        fill_in 'Street', with: '11 Revere Dr.'
        fill_in 'City', with: 'Barrington'
        fill_in 'State', with: 'Illinois'
        fill_in 'Zip', with: '60010'
        fill_in 'description', with: 'blahblah'

        click_button 'Submit'

        expect(current_path).to eq("/applications/#{Application.last.id}")
        expect(page).to have_content('In Progress')
      end

      it "will be taken back to the application page if they fail to fill out any part of the form" do
        visit '/applications/new'

        fill_in 'Name', with: 'Ted'
        fill_in 'Street', with: '11 Revere Dr.'
        fill_in 'City', with: 'Barrington'
        fill_in 'State', with: 'Illinois'
        fill_in 'Zip', with: '60010'

        click_button 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content('Your form is incomplete! Fill it out!!!')
      end
    end
  end
end
