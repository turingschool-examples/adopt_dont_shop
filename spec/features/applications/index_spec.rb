require 'rails_helper'

RSpec.describe 'applications index' do
  it 'shows all applications' do
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

    application_2 = Application.create!(name: "Joe Hashimura",
                                        street_address: "123 Hawaii Kai Dr.",
                                        city: "Honolulu",
                                        state: "HI",
                                        zip_code: "96825",
                                        description: "Cats are my life!",
                                        pet_names: ["Mochi", "Dango"],
                                        application_status: "pending")

    application_1.pets << pet_1
    application_1.pets << pet_2
    application_2.pets << pet_1
    application_2.pets << pet_2

    visit "/applications"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_2.name)
    expect(page).to have_link("New Application")
  end
end
