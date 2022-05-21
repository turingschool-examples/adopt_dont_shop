require 'rails_helper'

RSpec.describe "Applications Show Page" do
  it "should display applicat and all their attributes" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      scooby = shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      piglet = shelter.pets.create!(name: 'Piglet',  age: 1, breed: 'Micro Pig', adoptable: true, shelter_id: shelter.id)
      garfield = shelter.pets.create!(name: 'Garfield',  age: 4, breed: 'Orange Tabby Persian', adoptable: true , shelter_id: shelter.id)

      # application_1 = Application.create!(name: "Shaggy", address: "2541 Spooky Lane", city: "Coolsville", state: "Ohio", zipcode: "12345", rationale: "I want a best friend to eat scooby snacks with", status: "In Progress")
      # application_2 = Application.create!(name: "Jon Arbuckle", address: "711 Maple Street", city: "San Diego", state: "California", zipcode: "67890",   rationale: "Want a cat to hangout with my dog Odie", status: "In Progress")
      # application_3 = Application.create!(name: "Christopher Robin", address: "100 Acre Woods", city: "Wonderland", state: "Maryland", zipcode: "13579", rationale: "I want to go on adventures",  status: "In Progress")
      application_1 = scooby.applications.create!(name: "Shaggy", address: "2541 Spooky Lane", city: "Coolsville", state: "Ohio", zipcode: "12345", rationale: "I want a best friend to eat scooby snacks with", status: "In Progress")




      visit "applications/#{application_1.id}"

      expect(page).to have_content("Shaggy")
      expect(page).to have_content("2541 Spooky Lane")
      expect(page).to have_content("Coolsville")
      expect(page).to have_content("Ohio")
      expect(page).to have_content("12345")
      expect(page).to have_content("I want a best friend to eat scooby snacks with")
      expect(page).to have_content("In Progress")

      expect(page).to have_content(scooby.name)
      click_link("#{scooby.name}")

      visit "/pets/#{scooby.id}"
      expect(current_path).to eq("/pets/#{scooby.id}")

      expect(page).to have_content('Scooby')
      expect(page).to have_content(2)
      expect(page).to have_content(true)
      expect(page).to have_content("#{shelter.name}")

  end
end
