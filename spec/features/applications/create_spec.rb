require 'rails_helper'

RSpec.describe 'Create Application' do

  describe 'new application' do
    it "can display the application form" do
      application_1 = Application.create!(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: "80211", description: "I am a really responsible adult!", status: "Pending")

      visit '/applications/new'

      expect(page).to have_content("New Application")
      expect(find('form')).to have_content("Name")
      expect(find('form')).to have_content("Address")
      expect(find('form')).to have_content("City")
      expect(find('form')).to have_content("State")
      expect(find('form')).to have_content("Zipcode")
    end

    xit "allows form to be filled in and redirects to application show page" do
      application_1 = Application.create!(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: "80211", description: "I am a really responsible adult!", status: "Pending")

      visit '/applications/new'
      fill_in 'Name', with: "Michael Hicks"
      fill_in "Address", with: "858 S Emerson St"
      fill_in 'City', with: "Denver"
      fill_in 'State', with: "CO"
      fill_in 'Zipcode', with:'80211'

      click_button("Submit")

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Michael Hicks")
    end
  end
end
