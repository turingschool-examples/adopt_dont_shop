require 'rails_helper'

RSpec.describe "the Application show page" do
  it "should display an application" do
    shelter_1 = Shelter.create!(name: "Dumb Friends League",
                                rank: 2,
                                city: "Honolulu",
                                foster_program: true)

    pet_1 = shelter_1.pets.create!(name: "Mochi",
                        adoptable: true,
                        age: 2,
                        breed: "American Shorthair")
    pet_2 = shelter_1.pets.create!(name: "Dango",
                        adoptable: true,
                        age: 4,
                        breed: "Bengal")

    application_1 = Application.create!(name: "Mary Tanaka",
                                        street_address: "123 Kapiolani Blvd.",
                                        city: "Honolulu",
                                        state: "HI",
                                        zip_code: "98684",
                                        description: "I'm a pet lover!",
                                        pet_names: ["Mochi", "Dango"],
                                        application_status: "pending")

    application_1.pets << pet_1
    application_1.pets << pet_2

    visit "/applications/#{application_1.id}"

    within("#application-#{application_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_2.breed)
    end
  end
end
