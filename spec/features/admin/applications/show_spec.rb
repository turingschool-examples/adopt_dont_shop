require 'rails_helper'

RSpec.describe "admin applications show", type: :feature do
before :each do
  @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  @scrappy = Pet.create!(name: "Scrappy", age: 3, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  @application = Application.create!(status: "In Progress", name: "Murmuring Savannah", street: '123 Main',city: 'Leadville', state: 'CO',
  zip: 11111, description: "")
end
    describe "when I visit admin applications show page" do
    it "approves a pet for adoption" do
      visit "/applications/#{@application.id}"
      fill_in("search", with: "Scooby")
      click_on "Search"
      click_button "Adopt #{@scooby.name}"
      visit "/admin/applications/#{@application.id}"
      expect(page).to have_no_content("Application Approved")
      click_button "Approve Application for Scooby"
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_no_button("Approve Scooby")
      expect(page).to have_content("Application Approved")
    end
  end

end
