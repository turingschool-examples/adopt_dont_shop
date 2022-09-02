require "rails_helper"

# it("can click submit and take me to the new applications show page and see the information just submitted, and an indicator that this application is \"In Progress\"")
RSpec.describe("application creation") do
  it("takes the user to a form with Name,Street Address,City,State, and Zip Code, Why this is a good home") do
    visit("/applicants/new")
    fill_in("Name",     :with => "Jimmy John")
    fill_in("street_address",     :with => "303 Broadway")
    fill_in("City",     :with => "Denver")
    fill_in("State",     :with => "CO")
    fill_in("Zip code",     :with => 80122)
    expect(page).to(have_button("save"))

    it("can click submit and take me to the new applications show page and see the information just submitted, and an indicator that this application is \"In Progress\"") do
      click_button("submit")
      expect(page).to(have_content("Jimmy John"))
      expect(page).to(have_content("303 Broadway"))
      expect(page).to(have_content("Denver"))
      expect(page).to(have_content("CO"))
      expect(page).to(have_content("80123"))
      expect(page).to(have_content("I would love to have a companion"))
    end
  end
end
