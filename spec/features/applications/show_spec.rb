require "rails_helper"

RSpec.describe "Application Show Page" do
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

    @dean.pets << @crab
    @dean.pets << @fido
  end

  it "can show the application's attributes" do
    visit "/applications/#{@dean.id}"

    expect(page).to have_content(@dean.applicant_name)
    expect(page).to have_content(@dean.applicant_street_address)
    expect(page).to have_content(@dean.applicant_city)
    expect(page).to have_content(@dean.applicant_zipcode)
    expect(page).to have_content(@dean.description)
    expect(page).to have_content(@dean.status)
    expect(page).to have_content(@crab.name)
    expect(page).to have_content(@fido.name)
  end

  describe "Search and Add a pet to an application" do
    it "allows applicant to search for a pet by name" do
      visit "/applications"

      fill_in "Search", with: "Fido"
      click_on "Search"

      expect(current_path).to eq("/applications")
      # expect(page).to have_content(@fido.name)
    end

   it "allows applicant to click on adopt this pet" do
      visit "/applications/#{@dean.id}"

      fill_in :search, with: "Fido"
      click_on "Search", match: :first

      within("#Pet-#{@fido.id}") do
        click_on "Adopt this Pet"
      end

      expect(current_path).to eq("/applications/#{@dean.id}")
      expect(@dean.pets).to eq([@fido])

      expect(page).to have_content(@fido.name)
    end

    it "only allows applicant to submit when pets have been selected" do
      visit "/applications/#{@dean.id}"

      fill_in :description, with: "I want to get a dog for my kids"
      click_on "Submit Application"

      expect(current_path).to eq("/applications/#{@dean.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content(@crab.name)
      expect(page).to have_content("I want to get a dog for my kids")
      expect(page).to_not have_content("Add Pets to Adopt:")
    end
  end
end
