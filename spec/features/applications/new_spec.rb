require "rails_helper"

# it("can click submit and take me to the new applications show page and see the information just submitted, and an indicator that this application is \"In Progress\"")
RSpec.describe("application creation") do
  it("takes the user to a form with Name,Street Address,City,State, and Zip Code") do
    shelter = Shelter.create(    name: "Aurora shelter",     city: "Aurora, CO",     foster_program: false,     rank: 9)
    jimmy_application = Application.create!(    name: "Jimmy John",     street_address: "303 Broadway",     city: "Denver",     state: "CO",     zip_code: 80122,     description: "I would love to have a companion",     status: "Pending")
    pet_1 = Pet.create(    adoptable: true,     age: 7,     breed: "sphynx",     name: "Bare-y Manilow",     shelter_id: shelter.id)
    pet_2 = Pet.create(    adoptable: true,     age: 3,     breed: "domestic pig",     name: "Babe",     shelter_id: shelter.id)
    pet_3 = Pet.create(    adoptable: true,     age: 4,     breed: "chihuahua",     name: "Elle",     shelter_id: shelter.id)
    visit("/applications/new")
    fill_in("Name",     :with => "Jimmy John")
    fill_in("street_address",     :with => "303 Broadway")
    fill_in("City",     :with => "Denver")
    fill_in("State",     :with => "CO")
    fill_in("Zip Code:",     :with => 80122)
    expect(page).to(have_button("submit"))
    click_button("submit")
    expect(current_path).to(eq("/applications/#{Application.last.id}"))
  end

  xit("can click submit and take me to the new applications show page and see the information just submitted, and an indicator that this application is \"In Progress\"") do
    click_button("submit")
    expect(page).to(have_content("Jimmy John"))
    expect(page).to(have_content("303 Broadway"))
    expect(page).to(have_content("Denver"))
    expect(page).to(have_content("CO"))
    expect(page).to(have_content("80123"))
  end
end
