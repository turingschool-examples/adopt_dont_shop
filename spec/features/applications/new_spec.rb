require 'rails_helper'


# When I fill in this form with my:
#
# Name
# Street Address
# City
# State
# Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
RSpec.describe 'new application from' do
  it 'has a form for an applciant to fill out' do
    visit "/applications/new"

    within ".new-application" do

      fill_in :name, with: 'Derek'
      fill_in :city, with: "Denver"
      fill_in :zip, with: 80332
      fill_in :state, with: "CO"
      fill_in :street, with: "1309 Delaware St"
      fill_in :description, with: "I Love Pets"
      click_button 'Submit'
    end

      within '.app' do
        expect(page).to have_content("Applicant name: Derek")
        expect(page).to have_content("Why they're adopting: I Love Pets")
        expect(page).to have_content("Application Status: In Progress")
        expect(page).to have_content("Applicant Address: 1309 Delaware St Denver CO 80332")
      end
    end
    it 'returns error messages if form isnt completed' do
      visit "/applications/new"

      within ".new-application" do

        fill_in :name, with: nil
        fill_in :city, with: nil
        fill_in :zip, with: nil
        fill_in :state, with: nil
        fill_in :street, with: nil
        fill_in :description, with: nil
        click_button 'Submit'
      end
      save_and_open_page
      expect(current_path).to eq('/applications')
        within '.error-msgs' do
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Zip can't be blank")
        expect(page).to have_content("Street can't be blank")
        expect(page).to have_content("Description can't be blank")
        end
      end
    end
