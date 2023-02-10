require 'rails_helper'

RSpec.describe 'Application Show Page' do

  let!(:application) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, description: "I love them", pets_on_app: "Daisy, Sal", app_status: "Accepted") }

  describe 'User Story 1' do
    describe 'When I visit an applications show page' do
      it 'I see applicant info' do
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.name)
        expect(page).to have_content(application.street_address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
        expect(page).to have_content(application.description)
        expect(page).to have_content(application.app_status)
      end
    end
  end
end