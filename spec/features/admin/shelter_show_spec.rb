require 'rails_helper'

RSpec. describe "Admin Shelter show page", type: :feature do
  describe "displayed information" do
    before do
      @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20, street_address: "123 road street", state: "WA", zipcode: "55555")
      @shelter_2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Literally the Moon", rank: 30, street_address: "345 street avenue", state: "CO", zipcode: "44444")
      @shelter_3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Death City", rank: 40, street_address: "567 avenue road", state: "NV", zipcode: "33333")
      @shelter_4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Seattle", rank: 50, street_address: "789 avenue road", state: "HI", zipcode: "22222")
    end

    it "shows the correct info" do
      visit "/admin/shelters/#{@shelter_2.id}"
      expect(page).to have_content("Valhalla for Cats")
      expect(page).to have_content("345 street avenue Literally the Moon CO 44444")

      visit "/admin/shelters/#{@shelter_4.id}"
      expect(page).to have_content("Shangri La for Turtles")
      expect(page).to have_content("789 avenue road Seattle HI 22222")
    end
  end
end