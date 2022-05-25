require 'rails_helper'

RSpec.describe 'Admin Shelters index spec' do
  before :each do
    @ddfl = Shelter.create!(name: "Denver Dumb Friends League", foster_program: true, city: "Denver", rank: 5)
    @max = Shelter.create!(name: "Max Fund", foster_program: true, city: "Denver", rank: 5)
    @doggo = @ddfl.pets.create!(adoptable: true, age: 12, breed: "Cairn Terrior", name: "Sylus")
    @oprah = @doggo.applications.create!(name: "Oprah", street_address: "12 Bellaire St.", city: "Los Angeles", state: "CA", zip: "90006", status: "Pending")
  end

    it 'will show all shelters in reverse alphbetical order' do
      visit "/admin/shelters"
# save_and_open_page
      expect(@max.name).to appear_before(@ddfl.name)
    end

    it "has Shelters with Pending Applications section" do
      visit "/admin/shelters"

      expect(page).to have_content("Shelter's with Pending Applications")
      within "#pending" do
        expect(page).to have_content("Denver Dumb Friends League")
        expect(page).to_not have_content("Max Fund")
      end
    end
end
