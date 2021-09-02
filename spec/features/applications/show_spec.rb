require "rails_helper"

# Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

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
  end

  it "can show the application's attributes" do
    @dean.pets << @crab
    @dean.pets << @fido

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
end
