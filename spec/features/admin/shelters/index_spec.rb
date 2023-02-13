require 'rails_helper'

RSpec.describe "/admin/shelters" do
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  let!(:shelter_2) {Shelter.create!(name: "Max Fund", foster_program: true, city: "Aurora", rank: "2") }
  let!(:shelter_3) {Shelter.create!(name: "Human Society", foster_program: false, city: "Denver", rank: "3") }
  
  describe "When I visit the admin shelter index ('/admin/shelters')" do
    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      
      visit '/admin/shelters'
      
      expect(page).to have_content(shelter_1.name)

      expect(shelter_2.name).to appear_before(shelter_1.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)
    end
  end
end