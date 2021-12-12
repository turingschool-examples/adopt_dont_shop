require 'rails_helper'

RSpec.describe 'New Application' do
  describe 'As a visitor' do
    describe "I visit the new application page upon clicking the link on the pets index page" do
      it "creates a new application" do
        visit "/pets"

        click_on("Start an Application")

        expect(page).to have_content("New Application")
        fill_in('name', with: 'Harry')
        fill_in('street_address', with: '1234 Apple St')
        fill_in('city', with: 'Carson')
        fill_in('state', with: 'Nevada')
        fill_in('zipcode', with: '75429')
        fill_in('description', with: 'Because I am awesome')

        click_button("Submit")

        expect(page).to have_content("Status: In Progress")
      end

      it "Will not let a user not complete the form" do
        visit "/applications/new"

        fill_in('name', with: 'Harry')

        click_button("Submit")

        expect(page).to have_content("Application not complete: Please fill out all sections")
        expect(page).to have_button("Submit")
      end
    end
  end
end
