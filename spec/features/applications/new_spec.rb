require 'rails_helper'

RSpec.describe 'New Application' do
  describe 'As a visitor' do
    describe 'When I visit the new application form by clicking a link on the pet index' do
      it "I can create a new application" do
        visit '/applications/new'

        fill_in "Name", with: "Ted"
        fill_in "Street", with: "11 Revere Dr."
        fill_in "City", with: "Barrington"
        fill_in "State", with: "Illinois"
        fill_in "Zip", with: "60010"
        fill_in "description", with: "blahblah"

        click_button "Submit"

        expect(current_path).to eq("/applications/#{Application.last.id}")
        expect(page).to have_content("In Progress")
        expect(page).to have_content("Ted")
        expect(page).to have_content("11 Revere Dr.")
        expect(page).to have_content("Barrington")
        expect(page).to have_content("Illinois")
        expect(page).to have_content("60010")
        expect(page).to have_content("blahblah")
      end

      it "will be taken back to the application page if they fail to fill out any part of the form" do
        visit '/applications/new'

        fill_in "Name", with: "Ted"
        fill_in "Street", with: "11 Revere Dr."
        fill_in "City", with: "Barrington"
        fill_in "State", with: "Illinois"

        click_on 'Submit'
        save_and_open_page

        expect(current_path).to eq('/applications/new')
        within "#form" do
          expect(page).to have_content("Please fill out this field.")
        end
      end
    end
  end
end
