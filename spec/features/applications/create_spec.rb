require 'rails_helper'

describe "Application Create" do
  before do
    visit "/applications/new"
  end

  describe "it renders a new application form" do
    it "has all specifications" do
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip')
    end
  end

  describe 'applications create' do
    application1 = Application.create!(name: "Paul Leonard",
                                        address: "123 Smiley St.",
                                        city: "Atlanta",
                                        state: "Georgia",
                                        zip: "31768",
                                        description: "Single guy, 3 bedroom house on 7 acres. Lots of love to give!",
                                        status: "Pending")
    it "form is filled out and we are redirected to new app show page" do
      fill_in "Name", with: "Robin D."
      fill_in "Address", with: "CrackHouse Lane"
      fill_in "City", with: "Bellingham"
      fill_in "State", with: "Washington"
      fill_in "Zip", with: "99666"
      fill_in "Description", with: "My computer was stolen by a crackhead. I need a sweet pupper to cheer me up."
      fill_in "Status", with: "In Progress"
      click_button "Submit"

      new_app_id = Application.last.id

      expect(current_path).to eq("/applications/#{new_app_id}")
      expect(page).to have_content("CrackHouse Lane")
      expect(page).to have_content("Robin D.")
      expect(page).to have_content("In Progress")
      expect(page).to_not have_content(application1.name)
    end

    it "impartial form redirects to application new and flashes message" do
      fill_in "Name", with: "Robin D."
      fill_in "Address", with: "CrackHouse Lane"
      fill_in "City", with: "Bellingham"
      click_button "Submit"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Application not created: Fields can't be left blank.")
    end
  end
end
