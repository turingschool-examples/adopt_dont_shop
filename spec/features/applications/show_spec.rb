require 'rails_helper'

RSpec.describe 'the application show', type: :feature do
  it "shows application and it's attributes" do
    application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", description: "I'd be good because I love pets", application_status: "pending")

    application_2 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", description: "I'd be good because I already have many pets", application_status: "pending")

    shelter_1 = Shelter.create!(foster_program: 'true', name: "Shelter 1", city: "Denver", rank: "5")

    pet_1 = application_1.pets.create!(adoptable: "true", age: "3", breed: "Terrier", name: "Sparky", shelter_id: "#{shelter_1.id}")

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.applicant_name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_link("#{pet_1.name}", href: "/pets/#{pet_1.id}")

    visit "/applications/#{application_2.id}"

    expect(page).to have_content(application_2.applicant_name)
    expect(page).to have_content(application_2.street_address)
    expect(page).to have_content(application_2.city)
    expect(page).to have_content(application_2.state)
    expect(page).to have_content(application_2.zip_code)
    expect(page).to have_content(application_2.description)
    expect(page).to have_content(application_2.application_status)
    expect(page).to have_no_content(pet_1.name)
  end
end
