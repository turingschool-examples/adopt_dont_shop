require 'rails_helper'

RSPec.describe "New Application Page", type: :feature do
  describe "As a visitor" do
    describe "when I visit the pet index page" do
      it "shows a link to start an application" do
        click_link("Start an Application")
        expect(current_path).to eq("/owner_applications/new")
      end
    end


    describe "When I am on the new application page" do
      it "shows a blank form to fill out" do
        visit "/owner_applications/new"
        expect(page).to have_content('Name:')
        expect(page).to have_content('Street Address:')
        expect(page).to have_content('City:')
        expect(page).to have_content('State:')
        expect(page).to have_content('Zip Code:')
        expect(page).to have_button('Submit Application')
      end

      it "allows me to fill out the form and submit" do
        visit "/owner_applications/new"
        fill_in 'Name:', with: 'Wyatt'
        fill_in 'Street Address:', with: '559 S washington st'
        fill_in 'City:', with: 'Denver'
        fill_in 'State:', with: 'Colorado'
        fill_in 'Zip Code', with: 80209

        click_button 'Submit Application'

        expect(current_page).to eq "applications/show"

    end



    it "Shows an error if something isnt filled out and I click submit" do
      visit "/owner_applications/new"
      fill_in 'Name:' with: 'Wyatt'
      click_button 'Submit'
      expect(page).to have_content('Please fill in all fields')
      expect(current_path).to eq('/owner_applications/new')
      # expect(page).to have_content('Wyatt')
    end
  end
end

# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
