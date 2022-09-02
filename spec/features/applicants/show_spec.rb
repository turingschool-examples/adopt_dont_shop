require 'rails_helper'

RSpec.describe Applicant do
  describe 'applicant show page' do
    it 'shows applicants information' do
      app1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
                              city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs")
      app2 = Applicant.create!(name: "Cydney Whitemon", street_address: "124 S Way Avenue",
                              city: "Denver", state: "CO", zip_code: "80019", description: "Dogs Like Me")

      visit "/applicants/#{app1.id}"

      within "#applicant-#{app1.id}" do
        expect(page).to have_content("Name: Billy Wahl")
        expect(page).to have_content("Address: 123 S Street Way, Denver, CO 80123")
        expect(page).to have_content("Why I would make a good home: I Like Dogs")
        expect(page).to have_content("Application Status: In Progress")
      end
    end
  end
end