require "rails_helper"

RSpec.describe "pet adoption application creation", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: @shelter.id)
    @application = Applications.create!(name: "Kathy Jones", street_address: "456 First Ave", city: "Denver", state: "CO", zipcode: 80215)
  end

  describe "new application" do
    it "has Start an Application link on pet index page" do
      visit "/pets"
      click_link "Start an Application"

      expect(page).to have_current_path("/applications/new")
    end
  end

  describe "the new adoption application form" do
    it "renders the new adoption form" do
      visit "/applications/new"

      expect(page).to have_content("Pet Adoption Application")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street Address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
    end
  end

  describe "the new adoption application create form" do
    it "creates the new adoption application form and redirects to the new adoption application show page" do
      visit "/applications/new"

      fill_in "Name", with: "John Smith"
      fill_in "Street Address", with: "321 Main St"
      fill_in "City", with: "Littleton"
      fill_in "State", with: "CO"
      fill_in "Zip Code", with: 80333
      click_button "Submit"
      expect(page).to have_current_path("/applications/#{@application.id}")
      expect(page).to have_content("John Smith")
    end
  end
end
