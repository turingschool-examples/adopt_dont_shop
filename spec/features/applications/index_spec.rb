require "rails_helper"


RSpec.describe("Application INDEX Page") do
  before(:each) do
    @smithers_application = Application.create!(    name: "Smithers",     street_address: "99 Higgins Estate",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "I have a lot of land and no friends",     status: "In Progress")
    @homer_application = Application.create!(    name: "Homer",     street_address: "24 East Ridge",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "since the drinking hole closed i have a lot of time on my hands and no friends",     status: "In Progress")
    @shelter = Shelter.create(    name: "Mystery Building",     city: "Irvine CA",     foster_program: false,     rank: 9)
    @scooby = Pet.create(    name: "Scooby",     age: 2,     breed: "Great Dane",     adoptable: true,     shelter_id: @shelter.id)
    @bolt = Pet.create(    name: "Bolt",     age: 1,     breed: "Chihuahua",     adoptable: true,     shelter_id: @shelter.id)
    @pet_app_1 = PetApplication.create!(    pet: @bolt,     application: @smithers_application)
  end

  it("lists all the Applicants with their attributes") do
    visit("/applications")
    expect(page).to(have_content(@smithers_application.name))
    expect(page).to(have_content(@smithers_application.street_address))
    expect(page).to(have_content(@smithers_application.city))
    expect(page).to(have_content(@smithers_application.state))
    expect(page).to(have_content(@smithers_application.zip_code))
    expect(page).to(have_content(@smithers_application.description))
    expect(page).to(have_content(@homer_application.name))
    expect(page).to(have_content(@homer_application.street_address))
    expect(page).to(have_content(@homer_application.city))
    expect(page).to(have_content(@homer_application.state))
    expect(page).to(have_content(@homer_application.zip_code))
    expect(page).to(have_content(@homer_application.description))
  end
end
