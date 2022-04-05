require "rails_helper"

RSpec.describe "Application show page" do
  let!(:smith_app) { Application.create!(name: "Bobby Smith", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Rejected") }
  let!(:shelter) { Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }
  let!(:scooby) { Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Scooby", shelter_id: shelter.id) }
  let!(:scrappy) { Pet.create!(adoptable: true, age: 1, breed: "small dane", name: "Scrappy", shelter_id: shelter.id) }

  it "shows the application and all it's attributes" do
    visit "/applications/#{smith_app.id}"

    within ".application" do
      expect(page).to have_content(smith_app.name)
      expect(page).to have_content(smith_app.address)
      expect(page).to have_content(smith_app.city)
      expect(page).to have_content(smith_app.state)
      expect(page).to have_content(smith_app.zipcode)
      expect(page).to have_content(smith_app.description)
      expect(page).to have_content(smith_app.app_status)
      expect(page).to have_content("Pets applied for:")
    end
  end

  it "has 'Add Pet' section" do
    visit "/applications/#{smith_app.id}"

    expect(page).to have_content("Add a pet to this application")
    within ".pet_search" do
      expect(page).to have_content("Search for pet by name")
      expect(page).to have_button("Submit")
    end
  end

  it "has pet search function" do
    visit "/applications/#{smith_app.id}"

    fill_in "search_for_pet_by_name", with: "Scooby"
    click_button("Submit")
    within ".pet_results" do
      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Scrappy")
    end
  end
end
