require "rails_helper"

RSpec.describe "Application New Page" do
  describe "Fail to Fill In any Form Fields" do
    before :each do
      @shelter = Shelter.create!(name: "Central Park Shelter", address: "333 Central Street",
                                 city: "Denver", zipcode: "89999", foster_program: false, rank: 3)

      @crab = Pet.create!(name: "Crabby", age: 6, breed: "Bulldog", adoptable: true, shelter_id: @shelter.id)
      @fido = Pet.create!(name: "Fido", age: 3, breed: "Golden Retriver", adoptable: true, shelter_id: @shelter.id)

      @dean = Application.create!(applicant_name: "Dean Dumdun",
                                  applicant_street_address: "123 Main Street",
                                  applicant_city: "Denver",
                                  applicant_state: "CO",
                                  applicant_zipcode: "56789",
                                  description: "I already have a dog and would love for him to have friends",
                                  status: "In Progress")
    end

    it "has a link to start an application" do
      visit "/pets"

      click_on "Start an Application"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zipcode")
      expect(page).to have_field("Description")
      expect(page).to have_field("Status")
    end

    it "requires applicant to fill in all fields to be able to submit successfully" do
      visit "/applications/new"

      fill_in "Name", with: "Dean Durham"
      fill_in "Street Address", with: "123 Main Street"
      fill_in "City", with: ""
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "89768"
      fill_in "Description", with: "I would love for my dog to have friends"
      # fill_in "Status", with: "In Progress"

      click_on "Submit"

      expect(current_path).to eq("/applications/new")
      # expect(page).to have_content("Error: City can't be blank")
    end
  end
end
