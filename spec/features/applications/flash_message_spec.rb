# Starting an Application, Form not Completed
#
# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.
require 'rails_helper'

RSpec.describe Application, type: :feature do
  context 'displays flash messages if the application is submitted incorrectly' do
    it 'cannot create a application without a applicant name' do
      visit '/applications/new'

      click_on 'Submit'

      expect(page).to have_content("Application not created: required information missing.")
      expect(page).to have_button("Submit")
    end
  end
end
