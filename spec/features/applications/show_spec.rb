require "rails_helper"

RSpec.describe "applications show page", type: :feature do
  describe "us1: as a visitor" do
    before(:each) do
      @application1 = Application.create!(name: "Sean Morris",
                                          street_address: "305 E Thunderbird Dr.",
                                          city: "Fort Collins",
                                          state: "CO",
                                          zip_code: "80525",
                                          )
      visit "/applications/#{@application1.id}"
    end

    it "displays the name and address of the applicant" do
      expect(page).to have_content("Sean Morris")
      expect(page).to have_content("305 E Thunderbird")
      expect(page).to have_content("80525")
    end

    it "displays description and pets associated if exist" do
      expect(page).to have_content("Describe why you would make a good pet owner:")
      expect(page).to have_content("Empty")
      expect(page).to have_content("Pets:")
      expect(page).to have_content("Status: In Progress")
    end
  end
end
