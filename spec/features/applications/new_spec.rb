require 'rails_helper'

RSpec.describe "Application New" do
  describe 'if I do not fill out every field' do
    it 'returns to the /applications/new page, shows error message' do
      visit "/pets"

      expect(page).to have_link("Start an Application")

      click_link("Start an Application")
      expect(current_path).to eq("/applications/new")

      fill_in('Name', with: "Gregory Jones")
      fill_in('Street address', with: "1234 Happy LN")
      fill_in('City', with: "Astoria")
      fill_in('State', with: "OR")
      fill_in("Zipcode", with: "93475")

      click_on("Submit")
   
      expect(current_path).to eq('/applications/new')
save_and_open_page
      expect(page).to have_content("All Fields Required in Order to Submit")
    end
  end
end