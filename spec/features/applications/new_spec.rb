require 'rails_helper'

RSpec.describe 'Create Application' do

  describe 'new application' do
    it "can display the application form" do
      application_1 = Application.create!(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: 80211, description: "I am a really responsible adult!", status: "Pending")

      visit '/applications/new'

      expect(page).to have_content("New Application")
      expect(find('form')).to have_content("Name")
      expect(find('form')).to have_content("Address")
      expect(find('form')).to have_content("City")
      expect(find('form')).to have_content("State")
      expect(find('form')).to have_content("Zipcode")
    end

    it "allows form to be filled in and redirects to application show page" do
      application_1 = Application.create!(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: 80211, description: "I am a really responsible adult!", status: "Pending")

      visit '/applications/new'

      fill_in :name, with: "Michael Hicks"
      fill_in :address, with: "858 S Emerson St"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zipcode, with:'80211'

      click_button 'Submit'

      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content("Michael Hicks")
    end

    it "regenerates new form upon user error" do
      visit "/applications/new"

      click_button 'Submit'

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank")
    end
  end
end
